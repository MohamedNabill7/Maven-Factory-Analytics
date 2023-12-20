USE Mavendb;
/*Key tables 
	---> website_sessions and orders
    
Traffic source analysis
	Identifying the most useful traffic channels, campaigns, and keywords with strongest conversation rates

1. Where customers are coming from (Email, Social, Search, Direct Traffic)
2. Converation rate, Which is the percentage of those sessions which convert to our sale
3. Bid optimization based on device type
4. Traffic Trends examine website traffic patterns to understand when users are most active and where they are coming from
*/

-- Where are our customers coming from, and which specific campaign is driving the traffic
select distinct utm_source, utm_campaign from website_sessions
order by 1;

-- Identify the major of traffic sources
select utm_source, utm_campaign, count(distinct website_session_id) as sessions 
from website_sessions 
group by 1,2
order by sessions desc;

-- Conversions rate occurred for each traffic source or campaign.
select 
	ws.utm_source,
	ws.utm_campaign,
    count(distinct ws.website_session_id) as sessions ,
    count(distinct o.order_id) as orders,
    round(count(distinct o.order_id) / count(distinct ws.website_session_id)*100.0,2) as session_order_CVR
from website_sessions ws left join orders o on ws.website_session_id = o.website_session_id
group by 1,2
order by session_order_CVR desc;

-- Bid optimization based on the device type
select 
	ws.device_type,
    count(distinct ws.website_session_id) as sessions ,
    count(distinct o.order_id) as orders,
    round(count(distinct o.order_id) / count(distinct ws.website_session_id)*100.0,2) as session_order_CVR
from website_sessions ws left join orders o on ws.website_session_id = o.website_session_id
group by 1
order by session_order_CVR desc;

-- website traffic patterns at last three months to understand when users are most active and where they are coming from
select 
	date_format(created_at, '%Y-%m') as Date,
    utm_source,
    utm_campaign,
    count(distinct website_session_id) as sessions,
	count(case when device_type = 'desktop' then website_session_id else null end) as Desktop_Sessions,
    count(case when device_type = 'mobile' then website_session_id else null end) as Mobile_Sessions
from website_sessions
 where year(created_at) = 2015
 group by 1,2,3
 order by 1 asc, 4 desc;