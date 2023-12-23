use mavendb;

/*
Analyzing Website Perfrmance in last three months
	Analyzing Top Referral Sources & Website Pages & Entry Pages
    Analyzing Bounce Rates 
	Building Conversion Funnels 
	
Key tables: Website_page_views
*/

-- Top Referral Sources 
select 
	http_referer ,
    count(distinct website_session_id) as sessions
from website_sessions
where created_at between '2015-01-01' and '2015-03-01' -- arbitrary
group by 1
order by sessions desc;

-- o/p: 'gsearch' has the most referral source where users are coming from before landing on a specific page

-- Most Visited Main Pages 
select 
	pageview_url ,
    count(distinct website_session_id) as sessions
from website_page_views
where created_at between '2015-01-01' and '2015-03-01' -- arbitrary
group by 1
order by sessions desc;

-- o/p: 'product', 'lander-5' and 'home' pages get most of the traffic among the other pages. It will be a great idea to focus on enhancing these pages for the best customer experience.

-- Top entry pages 
with cte as
(
select 
    website_session_id,
    min(website_pageview_id) as min_page_view_id
from website_page_views
where created_at between '2015-01-01' and '2015-03-01' -- arbitrary
group by 1
)
select 
	w.pageview_url as landing_page,
    count(cte.website_session_id) as sessions_hit_landing_page
from cte left join website_page_views w on cte.min_page_view_id = w.website_pageview_id
group by 1
order by 2 desc; 

-- o/p: the 'lander-5' and 'home' are most entry pages 

-- Calculate the bounce rate 
-- First Page View (Landing Page)
create temporary table LP -- Landing Page
select 
	tab.website_session_id,
    website_page_views.pageview_url as landing_page
from 
	(select
		website_page_views.website_session_id,
		min(website_pageview_id) as min_pageView_id
	from website_page_views inner join website_sessions 
	on website_sessions.website_session_id = website_page_views.website_session_id and website_sessions.created_at between '2015-01-01' and '2015-03-01' -- arbitrary 
	group by 1) tab left join website_page_views on tab.min_pageView_id = website_page_views.website_pageview_id;

-- Bounce Sessions	
create temporary table bounced_sessions
select 
	LP.website_session_id,
    LP.landing_page,
	count(website_page_views.website_pageview_id) as count_of_pages_viewed
from LP
left join website_page_views on website_page_views.website_session_id = LP.website_session_id
group by 1,2
having count_of_pages_viewed = 1;

-- Group by between LP and Bounced session to get the bounce rate >>>> Bounce Rate = Bounce Rate=( Number of Single-page Visits / Total Visits ) × 100
select 
    LP.landing_page,
    count(distinct LP.website_session_id) as total_sessions,
    count(distinct bounced_sessions.website_session_id) as bounced_sessions,
    round(count(distinct bounced_sessions.website_session_id) / count(distinct LP.website_session_id) * 100.0,2) as bounced_rate
from LP left join bounced_sessions 
	on LP.website_session_id = bounced_sessions.website_session_id
group by 1
order by 4 asc;

-- Conversion Funnel
/*
	Build a conversion funnel to understand where we lose our 'gsearch' visitors between the new 'lander-1' page and placing an order
    Start with 'lander-1' and build the funnel all the way to our 'thank-you-for-your-order'. use data between August 5th and Sep 5th. 
*/
create temporary table session_level_made_it_flags
select 
	website_session_id,
    max(products_page) as product_made_it,
    max(mr_fuzzy_page) as mr_fuzzy_made_it,
    max(cart_page) as cart_made_it,
    max(shipping_page) as shipping_made_it,
    max(billig_page) as billig_made_it,
    max(thankyou_page) as thankyou_made_it
from
	(select  
		website_sessions.website_session_id,
		website_page_views.created_at,
		website_page_views.pageview_url,
		CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
		CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mr_fuzzy_page,
		CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
		CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
		CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billig_page,
		CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
	from website_sessions left join website_page_views 
		on website_sessions.website_session_id = website_page_views.website_session_id
	where website_sessions.utm_source = 'gsearch'
        and website_sessions.utm_campaign = 'nonbrand'
        and  website_sessions.created_at between '2012-08-05' and '2012-09-05' -- arbitrary
	order by 1,2) as PageView_level
group by 1;

select * from session_level_made_it_flags;

-- show the progression of the sessions to the thank you page
select 
    COUNT(DISTINCT website_session_id) AS sessions,
	COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS to_products,
	COUNT(DISTINCT CASE WHEN mr_fuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mr_fuzzy,
	COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart,
	COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS to_shipping,
	COUNT(DISTINCT CASE WHEN billig_made_it = 1 THEN website_session_id ELSE NULL END) AS to_billing,
	COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) AS to_thankyou
from session_level_made_it_flags;

-- show the click rates 
select 
	COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT website_session_id) AS lander_click_rate,
	COUNT(DISTINCT CASE WHEN mr_fuzzy_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS products_click_rate,
	COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN mr_fuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS mr_fuzzy_click_rate,
	COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) /COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END)  AS cart_click_rate,
	COUNT(DISTINCT CASE WHEN billig_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS shipping_click_rate,
	COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN billig_made_it = 1 THEN website_session_id ELSE NULL END) AS billing_click_rate
from session_level_made_it_flags;
-- we should focus on 'lander', 'mr-fuzzy' and 'billing' pages which have the lowest click rate 



    
    
    