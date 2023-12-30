# Maven-Factory-Analytics
Maven Fuzzy Factory Data analysis using MySQL and visualize by Tableau.

#### Introduction

I worked as an eCommerce Database Analyst for Maven Fuzzy Factory, a new online retailer that had just launched its first product. I collaborated with the CEO, Marketing Manager, and Website Manager to analyze and optimize marketing channels, measure and test website conversion performance, and explore the product portfolio to understand the impact of new product launches in order to help the business make better decisions.


#### Entity Relation Diagram

![Alt text](ERD.png)

Working with **six related tables**, which contain **eCommerce** data about:

    Website Activity
    Products
    Orders and Refunds

**Six tables are:**

**Orders:** Store the purchases that customers are placing.

**Order_items:** Various orders that customers could purchases more than items.

**Order_item_refunds:** When customers are complaining and are issued a refund.

**Products:** Products name.

**Website_page_views:** Log of page view that a user saw when they were on eCommerce website.

**Website_sessions:** Where our traffic is coming from and traffic sources.


**Before jumping into the project, I would like to briefly cover some web/digital marketing buzzwords :-**
    
    UTM parameters: Are small pieces of code that are added to the end of a URL used to track the source of the traffic
    
    By tracking them, businesses can see which of their paid marketing campaigns are most effective.They can also see how different traffic sources and 
    campaigns are performing in terms of website activity and conversions.

     ------------- ------------------------------------------------------------------------- -------------------------
    | utm_source  | Identifies which site sent the traffic and is a required parameter.     | utm_source=google       |
    | ------------| ----------------------------------------------------------------------- | ------------------------|
    | utm_campaign| Identifies a specific product promotion or strategic campaign.          | utm_campaign=spring_sale|
    | ------------|-------------------------------------------------------------------------|-------------------------|
    | utm_content | Identifies what specifically was clicked to bring the user to the site, | utm_content=logolink or |
    |             |  such as a banner ad or a text link. It is often used for A/B testing   | utm_content=textlink    |
    |             | and content-targeted ads.                                               |                         |
     ------------- ------------------------------------------------------------------------- -------------------------  

#### Contents:
    Traffic Sources Analysis
    Website Performance Analysis
    Channel Portfolio Management
    Business Patterns and Seasonality
    Product-Level Analysis
    User-Level Analysis
    Data Driven Report


#### Traffic Sources Analysis

**Key Tables :**    website_sessions, orders

*   Find the Top Traffic Sources
*   Traffic Source Conversion Rates
*   Bid optimization based on the device type

#### Website Performance Analysis

**Key Tables :**    website_sessions, website_pageviews

*   Analyzing Top Referral Sources & Website Pages & Entry Pages
*   Analyzing Bounce Rates 
*   Building Conversion Funnels 


#### Channel Portfolio Management

**Key Tables :**    website_sessions, orders  

*   Analyzing Channel Portfolio
*   Comparing Channel Characteristics
*   Cross Channel Bid Optimization
*   Impact of Bid Changes
*   Analyzing Free Channels


#### Business Patterns and Seasonality

**Key Tables :**    website_sessions, orders

*   Analyzing Seasonality
*   Analyzing Business Patterns


#### Product-Level Analysis

**Key Tables :**    website_sessions, website_pageviews, orders, order_items, order_item_refunds

*   Product Sales Analysis
*   Product Launch Sales Analysis
*   Product Level Website Analysis
*   Product Pathing Analysis
*   Product Conversion Funnel
*   Cross Sale Analysis
*   Portfolio Expansion Analysis
*   Quailty issues & Refunds


#### User-Level Analysis

**Key Tables :**    website_sessions, orders

*   Analyzing Users Repeat Visit
*   Analyzing Purchase Behavior (Repeat Channel, New & Repeat Conversion Rates)


#### Data Driven Report

**Key Tables :**    website_sessions, website_pageviews, orders, order_items

<div class='tableauPlaceholder' id='viz1703906244526' style='position: relative'><noscript><a href='#'><img alt='Dashboard 2 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ma&#47;MavenFuzzyFactory-TrafficSourceAnalysis&#47;Dashboard2&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='MavenFuzzyFactory-TrafficSourceAnalysis&#47;Dashboard2' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ma&#47;MavenFuzzyFactory-TrafficSourceAnalysis&#47;Dashboard2&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1703906244526');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.minWidth='700px';vizElement.style.maxWidth='1720px';vizElement.style.width='100%';vizElement.style.minHeight='587px';vizElement.style.maxHeight='887px';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.minWidth='700px';vizElement.style.maxWidth='1720px';vizElement.style.width='100%';vizElement.style.minHeight='587px';vizElement.style.maxHeight='887px';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else { vizElement.style.width='100%';vizElement.style.height='827px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
