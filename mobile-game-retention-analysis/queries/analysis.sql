-- retentions with respect to versions
select 
  version,
  count(*) as users,
  avg(cast(retention_1 as int64)) as day1_retention,
  avg(cast(retention_7 as int64)) as day7_retention
from mobile-game-2.retention.cookie_cats
group by version

-- engagement analysis
select
  retention_1,
  count(*) as users,
  avg(sum_gamerounds) as avg_rounds,
from mobile-game-2.retention.cookie_cats
group by retention_1

-- version-level engagement
select
  version,
  count(*) as users,
  avg(sum_gamerounds) as avg_rounds
from mobile-game-2.retention.cookie_cats
group by version


-- quartile analysis

SELECT
  version,
  APPROX_QUANTILES(sum_gamerounds, 4) as quartiles
FROM mobile-game-2.retention.cookie_cats
GROUP BY version;


-- outlier temizliği 


with percentiles as (
  select
    version,
    approx_quantiles(sum_gamerounds, 100)[offset(95)] as p95
  from mobile-game-2.retention.cookie_cats
  group by version
)

select
  c.version,
  avg(c.sum_gamerounds) as avg_without_top_5_percent
from mobile-game-2.retention.cookie_cats c
join percentiles p
on c.version = p.version
where c.sum_gamerounds <= p.p95
group by c.version;
 
-- segmentation-retention relationships 

select
  case  
    when sum_gamerounds <= 10 then '0-10'
    when sum_gamerounds <= 30 then '11-30'
    when sum_gamerounds <= 60 then '31-60'
    when sum_gamerounds <= 100 then '61-100'
    else '100+'
  end as round_bucket,
  count(*) as users,
  avg(cast(retention_1 as int64)) as retention_rate
from mobile-game-2.retention.cookie_cats
group by round_bucket


-- version and bucket analysis
SELECT
  version,
  CASE
    WHEN sum_gamerounds <= 30 THEN '0-30'
    WHEN sum_gamerounds <= 60 THEN '31-60'
    ELSE '60+'
  END as bucket,
  COUNT(*) as users,
  AVG(CAST(retention_1 AS INT64)) as retention_rate
FROM mobile-game-2.retention.cookie_cats
GROUP BY version, bucket
ORDER BY version, bucket;


-- gate analysis for 60+ players

select
  version,
  count(*) as users,
  avg(cast(retention_1 as int64)) as day1_retention,
  avg(cast(retention_7 as int64)) as day7_retention,
  avg(sum_gamerounds) as avg_rounds
from mobile-game-2.retention.cookie_cats
where sum_gamerounds > 60
group by version


-- micro segmentation analysis

SELECT
  version,
  CASE
    WHEN sum_gamerounds BETWEEN 61 AND 100 THEN '61-100'
    WHEN sum_gamerounds BETWEEN 101 AND 200 THEN '101-200'
    WHEN sum_gamerounds BETWEEN 201 AND 500 THEN '201-500'
    ELSE '500+'
  END as heavy_bucket,
  COUNT(*) as users,
  AVG(CAST(retention_1 AS INT64)) as day1_retention,
  AVG(CAST(retention_7 AS INT64)) as day7_retention,
  AVG(sum_gamerounds) as avg_rounds
FROM mobile-game-2.retention.cookie_cats
WHERE sum_gamerounds > 60
GROUP BY version, heavy_bucket

