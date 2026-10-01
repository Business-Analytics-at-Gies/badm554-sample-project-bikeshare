-- 05_dim_rider_type.sql   Owner: Member C
-- One row per pass or membership name found in the trips, with a simpler rider group.
CREATE OR REPLACE TABLE sample_bikeshare_star.dim_rider_type AS
SELECT
  ROW_NUMBER() OVER (ORDER BY subscriber_type) AS rider_type_key,
  subscriber_type,
  CASE
    WHEN subscriber_type IN ('Student Membership', 'U.T. Student Membership') THEN 'Student'
    WHEN subscriber_type IN ('Annual', 'Local365', 'Local365+Guest Pass')     THEN 'Annual member'
    WHEN subscriber_type IN ('31 Day Pass', 'Local31')                        THEN 'Monthly member'
    WHEN subscriber_type IN ('1 Day Pass', '24 Hour Walk Up Pass', '3-Day Weekender', 'Explorer',
                             'Pay-as-you-ride', 'Single Trip (Pay-as-you-ride)', 'Single Trip Ride')
                                                                              THEN 'Casual'
    ELSE 'Other'
  END AS rider_group
FROM (SELECT DISTINCT subscriber_type FROM sample_bikeshare_star.stg_trips);
