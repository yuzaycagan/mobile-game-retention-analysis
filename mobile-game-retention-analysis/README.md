\# Mobile Game A/B Test – Gate Placement Retention Analysis



This project analyzes an A/B test conducted in a mobile puzzle game to evaluate how gate placement impacts retention and player engagement.



Two variants were tested:



gate\_30



gate\_40



\## Goal



Compare gate\_30 and gate\_40 in terms of:



Day 1 Retention



Day 7 Retention



Player Engagement (Total Game Rounds)



Behavioral differences across engagement segments



\## Dataset



Columns:



* version (gate\_30 / gate\_40)
* sum\_gamerounds
* retention\_1 (boolean)
* retention\_7 (boolean)



\##  Metrics



\###  Version-Level Retention

Results

Version	Users	Day1 Retention	Day7 Retention

gate\_30	44,700	44.82%	19.02%

gate\_40	45,489	44.23%	18.20%

\#### Insight



gate\_30 performs slightly better in both D1 and D7.



Differences are modest (~0.6pp D1, ~0.8pp D7).



No dramatic retention collapse from gate\_40 at total population level.



\### Engagement vs Retention Relationship

Results

retention\_1	Users	Avg Rounds

false	50,036	17.35

true	40,153	94.90

\#### Insight



Retained users play ~5x more rounds.



Engagement depth is strongly correlated with retention.



sum\_gamerounds is a powerful behavioral predictor.



\### Version-Level Engagement

Results

Version	Users	Avg Rounds

gate\_30	44,700	52.46

gate\_40	45,489	51.30

\#### Insight



Slight engagement advantage for gate\_30.



Difference is small (~1.1 rounds).



Required distribution-level validation.



\### Quartile Distribution Analysis

Results

Version	Min	Q1	Median	Q3	Max

gate\_30	0	5	17	50	49,854

gate\_40	0	5	16	52	2,640

\#### Insight



Median and quartiles are almost identical.



Extreme outlier in gate\_30 (49k rounds).



Engagement difference likely driven by whales.



\### Outlier Removal (Top 5%)



After removing the top 5% of players:



Version	Avg Rounds (Top 95%)

gate\_30	33.23

gate\_40	33.09

\#### Insight



Engagement difference disappears.



Population-level behavior is nearly identical.



Initial average gap was outlier-driven.



\### Engagement Segmentation

Results (Retention\_1 by Round Bucket)

Round Bucket	Users	Retention Rate

0–10	35,989	11.34%

11–30	21,573	45.48%

31–60	12,965	70.68%

61–100	7,277	81.76%

100+	12,385	89.99%

\#### Insight



Retention increases monotonically with engagement.



Strong behavioral threshold around 30 rounds.



Deep engagement strongly predicts long-term retention.



\###  Version × Engagement Buckets

Results (Retention\_1)

Version	Bucket	Users	Retention Rate

gate\_30	0–30	28,342	24.24%

gate\_40	0–30	29,220	24.04%

gate\_30	31–60	6,731	70.70%

gate\_40	31–60	6,234	70.66%

gate\_30	60+	9,627	87.31%

gate\_40	60+	10,035	86.60%

\#### Insight



Differences are minimal across low and mid segments.



Slight advantage for gate\_30 in 60+ segment.



Needed deeper breakdown within heavy players.



\### Heavy Players (60+ Rounds)

Results

Version	Users	Day1 Ret	Day7 Ret	Avg Rounds

gate\_30	9,627	87.31%	60.40%	185.40

gate\_40	10,035	86.60%	58.31%	177.95

\#### Insight



D1 difference small.



D7 retention ~2pp higher for gate\_30.



Engagement slightly higher for gate\_30.



Impact appears stronger among heavy users.



\### Micro-Segmentation (Heavy Breakdown)

Results

Version	Segment	Users	Day7 Retention

gate\_30	61–100	3,532	41.45%

gate\_40	61–100	3,745	36.58%

gate\_30	101–200	3,490	61.29%

gate\_40	101–200	3,672	61.41%

gate\_30	201–500	2,178	82.97%

gate\_40	201–500	2,189	82.82%

gate\_30	500+	427	94.85%

gate\_40	500+	429	96.27%

Critical Insight



Retention difference is concentrated in:



\- 61–100 round segment



~5 percentage point D7 retention gap.



Differences disappear in deeper segments.



Ultra-core users (200+) behave similarly in both variants.



\## Final Conclusion



Overall retention difference is modest.



Engagement difference disappears after removing outliers.



The meaningful behavioral impact appears in the mid-heavy segment (61–100 rounds).



Product Interpretation



gate\_40 does not harm:



Casual players



Ultra-core players



However, it may negatively affect:



!! Players in the transition phase toward becoming core users.



This phase is critical for long-term retention and LTV growth.



\## Tools



SQL (BigQuery)



Distribution Analysis (Quartiles)



Outlier Filtering (P95)



Behavioral Segmentation



\## Author



Çağan Yüzay

