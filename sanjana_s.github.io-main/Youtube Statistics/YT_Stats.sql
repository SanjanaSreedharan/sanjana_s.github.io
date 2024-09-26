# Top continents in YouTube in the sense of Upload, views , Earnings

select 
case 
	when Country in ( "Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'
	when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,
sum(subscribers) as Total_Subs,
sum(uploads) as Total_uploads,
sum(`video views`) as Total_views,
round(sum(highest_yearly_earnings),0) as Total_earnings,
count(Youtuber) as no_of_Youtubers
from portfolio.YouTube_Statistics
group by continents
order by 5 desc
;

# percentage of pay per continent
with percent_pay as(
select 
case 
	when Country in ( "Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'
	when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,
    round(sum(highest_yearly_earnings),0) as Total_Earnings
    from portfolio.youtube_statistics
    group by 1
    order by 2 desc
    )
    #Africa,Asia,Europe,North America, South America, Australia &Oceania
    select 
    sum(Total_Earnings) as Total_Earnings,
    round(1.0*sum(case when continents='Africa' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,2) as Perc_Earning_Africa,
    round(1.0*sum(case when continents='Asia' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,2) as Perc_Earning_Asia,
    round(1.0*sum(case when continents='Europe' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,2) as Perc_Earning_Europe,
    round(1.0*sum(case when continents='North_America' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,2) as Perc_North_America,
    round(1.0*sum(case when continents='South_America' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,2) as Perc_South_America,
    round(1.0*sum(case when continents='Australia_and_Oceania' then Total_Earnings else 0 end)/nullif(sum(Total_Earnings),0)*100,5) as Perc_Australia_and_Oceania
   
   from percent_pay
    ;
    
   #Percent pay by country
    with perc_country as(
    select Country,
    round(sum(highest_yearly_earnings),0) as Total_Earnings
    from portfolio.youtube_statistics
    group by 1
    order by 2 desc
    )
   select sum(Total_Earnings) as Total_Earnings,
   round(1.0*sum(case when Country='United States' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_US,
   round(1.0*sum(case when Country='India' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_India,
   round(1.0*sum(case when Country='Brazil' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_Brazil,
   round(1.0*sum(case when Country='South Korea' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_SouthKorea,
   round(1.0*sum(case when Country='United Kingdom' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_UK,
   round(1.0*sum(case when Country='Pakistan' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_Pakistan,
   round(1.0*sum(case when Country='Argentina' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_Argentina,
   round(1.0*sum(case when Country='Russia' then Total_Earnings else 0 end)/ nullif(sum(Total_Earnings),0)*100,2) as perc_Russia

  from perc_country
   ;
   
   #Top Channel with most views
   select channel_type,
   sum(`video views`)
   from portfolio.youtube_statistics
   group by 1
   order by 2 desc
   limit 8
   ;
#Top 5 TouTube Channels in terms Highest Earnings and Percentage earnings
with Top_YT as(
select Youtuber,highest_yearly_earnings,
sum(highest_yearly_earnings) over() as Total_Earnings,
row_number() over(order by highest_yearly_earnings desc) as Ranks
from portfolio.youtube_statistics
)
select Youtuber,
round((highest_yearly_earnings/Total_Earnings)*100,2) as percentage_earning,
Ranks
from Top_YT
where Ranks < 6
;
#Top 5 YT channels in terms of subscribers
select Youtuber,
subscribers
from portfolio.youtube_statistics
order by subscribers desc
limit 5
;
# Top  Youtube channels in terms of views
select Youtuber,(`video views`) as video_views
from portfolio.youtube_statistics
order by video_views desc
limit 5
;
