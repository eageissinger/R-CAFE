Data Citation:

Geissinger, E.A., Gregory, R.S., Laurel, B.J., and Snelgrove, P.V.R. 2020. Data from: Food and initial size influence overwinter survival and condition of a juvenile 
marine fish (age-0 Atlantic cod). V2. Scholars Portal Dataverse. https://doi.org/10.5683/SP2/8KUABH.

subject: Overwinter growth, survival, and condition of juvneile Atlantic cod (Gadus morhua)
funding agencies: This research is sponsored by the NSERC Canadian Healthy Oceans Network and its Partners: Department of
Fisheries and Oceans Canada and INREST (representing the Port of Sept-Îles and City of Sept-Îles).
background: We divided age-0 Atlantic cod into small (60-83 mm SL, standard length) and large (90-110 mm SL) size classes, and subdivided size 
Atlantic cod were fed freeze dried krill (Euphausia superba) from JEHMCO Aquatic Breeder Supplies, Inc. (55% protein, 26% fat, 0.81% total carbohydrates, 461 kcal/100g).
We configured 36 100-L rectangular tanks with flow-through water system from a deep-water source at Ocean Sciences Centre of Memorial University of Newfoundland, at an average 
flow rate of 33 mL·s-1. We randomly assigned treatment, fish size, and ration to 36 tanks filled with water filtered through a 500 µm filter bag and maintained at ambient 
water temperature, which we measured daily in the morning and evening. Nine fish were assigned to each tank and acclimated for 20 days. At the start of the experiment, 
we euthanized 40 fish (18 small, 22 large) with tricaine methanesulfonate (TMS) in order to evaluate condition on day 0. 
variables that are not measured (blank cells) are specified by NA
format: all file formats are comma separted (.csv)
All R code is available at https://github.com/eageissinger/CHONe-1.2.1/tree/master/condition-experiment

title: Condition measurements (raw)
file name: CHONE121_codcondition.csv
date of data collection:
- start: 2016-12-16
- end: 2017-04-24
method of data collection: Standard length and wet weight (whole body) were measured for all cod. Liver was dissected and weighed, and eviscerated 
wet weight was measured. Liver and eviscerated bodies were stored at -20 °C prior to drying the body and liver. Bodies were dried for 48 hours and 
livers for 24 hours at 65 °C. 
information on variables:
- year: year of measurement
- month: month of measurement
- day: day of measurement
- time: time of measurement (Newfoundland Time [NT])
- tank: tank assignment, out of 36
- mmSL: standard length of Atlantic cod (mm)
- wet_weight: wet weight of whole body, blotted dry with paper towel (g)
- wet_liver: wet weight of liver (g)
- wet_evis: wet weight of eviserated body (g)
- dry_liver: dry weight of liver (mg)
- dry_evis: dry eviserated weight of body (g)
- mortality: if fish died mid-study (1) or sampled at beginning or end of study (0)
- notes: notes on fish measurements

title: Length and Weight of Atlantic Cod
file name: CHONE121_codlengthweight.csv
date of data collection:
- start: 2016-12-31
- end: 2017-04-24
method of data collection: Wild caught age-0 Atlantic cod were collected from Newman Sound, NL, Canada, in November 2016. 
Cod were acclimated to laboratory settings in holding tanks for 2 weeks, followed by acclimation to experimental tanks for one week.
Cod were measured once a month to adjust feeding ration and assess growth through the experiment, holding them in 30 mg·L-1 of TMS 
prior to measurement for standard length (±1 mm) and wet weight (±0.01 g). Prior to weighing in a tared container of seawater, we blotted cod dry through a 
fine mesh net to remove excess water.
information on variables:
- year: year of measurement
- month: month of measurement
- day: day of measurement
- tank: tank assignment, out of 36
- size: size class of fish. Small cod ranged between 60-83 mm standard length, large cod ranged between 90-110 mm standard length
- ration: feeding ration for each tank. There are four feeding rations (0.0%, 2.5%, 5.0%, 10.0%). Feeding ration is % dry bodyweight for total mass in tank
- length_mm: standard length of Atlantic cod (mm)
- weight_g: weight of Atlantic cod (g)
- fish_number: number assignment based on growth and length from previous measurement. This is an estimate, and is not validated, as there were no unique identifiers for
individual fish.

title: Tank Assignments
file name: CHONE121_tankassignments.csv
date of data collection: December 2016
method of data collection: Atlantic cod were divdied into small (60-83 mm standard length) and large (90-110 mm standard length) size
classes. Tanks were then subdivided across four feeding treatments (0.0%, 0.5%, 1.0%, 2.0%). Tanks were selected using stratified random
sampling to increase distribution across the tank space.
information on variables:
- tank: tank number
- size: size class, small (60-83 mm SL at start of experiment), large (90-110 mm SL at start of experiment)
- ration: feeding ration for each tank. There are four feeding rations (0.0%, 2.5%, 5.0%, 10.0%). Feeding ration is % dry bodyweight for total mass in tank

title: Tank Temperatures
file name: CHONE121_tanktemperature.csv
date of data collection: 
- start: 2016-12-20
- end:2017-4-24
method of data collection: digital thermometer measured twice a day (am/pm) in 36 tanks
information on variables:
- year: year of measurement
- month: month of measurement
- day: day of measurement
- time: time of measurement (Newfoundland Time [NT])
- tank: tank measured, tanks are assigned from 1 to 36
- temperature: degree Celsius