# cycling
Some simple formulas for estimating cycling power, and for estimating the speed you will go for a given power, grade, CdA and Crr.

- CdA is the coefficient of drag times frontal surface area (~0.35 for bar tops, 0.3 for drops and 0.25 for aero bars).
- Crr is the coefficient of rolling resistance (around 0.005 for most tires, 0.003 for race tires).
- wt is the weight of the rider in lbs
- bike_wt is the weight of the bike and gear in lbs
- distance is in miles
- elev is in feet
- wind_speed is the optional. This is defined as the speed of the wind going against the direction you're cycling

The formulas used here estimate the power used to overcome gravity, rolling resistance and aerodynamic resistance. 
I've taken them from this website: http://anonymous.coward.free.fr/wattage/cda/indirect-cda.pdf

For the best power estimate, do a long climb with no wind. This reduces potential errors from aerodynamic power estimates,
which seem particularly tricky to get right. If you have a power meter, you could also use this to estimate your CdA.

#performance management chart

The performance management chart (PMC) is commonly used to model the positive (fitness, CTL) and negative (fatigue, ATL) effects of training.
Both effects use an exponential weighted average, with a shorter time constant for fatigue.
The default values used in the template are 42 days for Chronic Training Load (CTL, fitness) and 7 days for Acute Training Load (ATL, fatigue).

Training is modeled numerically based on duration and percentage of race pace.
A score of 100 corresponds to 100% of race pace effort for one hour, a score of 50 could be a 50% effort for one hour or a 100% effort for half an hour.
While this score can be determined using a power meter or heart rate monitor, it can also be estimated based on how strong you feel your effort was.
