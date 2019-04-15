# A Data-Backed, Visual Exploration of the Opioid Crisis
A work by Shukry Zablah (szablah20@amherst.edu) and Raymond Nzaba (rsaitoti20@amherst.edu)

Link to App: https://szablah.shinyapps.io/opioid/

## The Opioid Epidemic

### The numbers at a glance

- From 1999 to 2016, more than 630,000 people have died from a drug overdose.
-  Around 66% of the more than 63,600 drug overdose deaths in 2016 involved an opioid.
-  In 2016, the number of overdose deaths involving opioids (including prescription opioids and illegal
opioids like heroin and illicitly manufactured fentanyl) was 5 times higher than in 1999.
-  On average, 115 Americans die every day from an opioid overdose

### Brief History

From 1999 to 2016, more than 630,000 people have died from a drug overdose.
- Around 66% of the more than 63,600 drug overdose deaths in 2016 involved an opioid.
- In 2016, the number of overdose deaths involving opioids (including prescription opioids and illegal
opioids like heroin and illicitly manufactured fentanyl) was 5 times higher than in 1999.
- On average, 115 Americans die every day from an opioid overdose

### Why should you care? 

The opioid crisis eats up the successful entrepreneur and the jobless person alike. It is a pervasive problem that has persisted and been responsible for the deaths of thousands and the decreasing life expectancy of Americans. While it is true that every strata of society is in danger from the effects of this epidemic, its effects vary widely across age groups and gender. Our project is significant because it will be an accessible way to know more about this silent disaster. Our aim is that people that don’t know about the crisis will be able to talk knowledgeably about what it is and how it affects society, and that those who already know about it will be able to correct and enhance their understanding of the numbers behind the situation.

### The approach taken: 

In order to better understand the toll and impact of the epidemic, we tracked the trends and patterns by considering the following:

1. The total number of deaths per age group across the years.
2. Comparisons of different causes of deaths among different age groups.
3. Top counties worst hit by drug deaths.
4. Crude death rates overtime, for all races and sexes, by state.
5. Case study of 2014; Opioid prescription rates and providers
6. Trends by race.

### Data

The data we used for our analysis was obtained from the following sources:

1. https://wonder.cdc.gov/ (Multiple csvs)

This is an online database belonging to the CDC. It contains wide ranging data for Epidemiologic Research.  We tried using R packages to query the website’s API, but they were not as user friendly as we hoped.  Eventually we resorted to performing direct queries on the website itself, but this had its own limitations in terms of size. Forty queries were done (each had a limit of 75,000 lines) to obtain 1999 - 2016 data on drug poisoning mortality rates stratified by state and county.

2. https://data.world/cms/e4ka-3ncx (csv)

This dataset from the The Centers for Medicare & Medicaid Services contains the information on the individual opioid prescribing rates of health providers that participate in Medicare Part D program. This file provides data on the number and percentage of prescription claims (includes new prescriptions and refills) for opioid drugs, and contains information on each provider’s name, specialty, state, and ZIP code.

3. https://data.world/jessicayung/opioid-prescriptions-dispensed (csv)

Includes the number of opioid analgesic prescriptions dispensed by US retail pharmacies from 2009 to 2015.  This dataset includes breakdowns by type of opioid analgesic.

### Interesting findings

- The death rates across all groups exhibited a steady increase. However, the most hit age group in 2016 was 15 - 24 year olds.
-  Total deaths across age group vary vastly depending on whether the cause of death was suicide,
intentional or undetermined.
-  The worst hit area was Jefferson County, Colorado.
- All states had similar trends for both sexes and all races.
- Some of the cities with the highest Opioid prescription rates were Sacramento (CA), Piedmont (SD)
and Stringtown (OK).

### Limitations

We are aware that there exists huge illegal drug market whose data would be really valuable in helping
us make sense of drug related deaths and overdoses. If we had more time and resources, the next step in
this project would have been to obtain extensive prescription data and narrow down on the most abused
substances like heroin or oxycodone.

### Working with Shiny

Our whole presentation is aided by a series of navigation buttons that enable us to change between different slides in an intuitive way as we break down the topic and advance through the loop around the slideshow containing different reactive elements, plots and pictures. Our app is posted on the internet and can be used by anyone as a tool to inform and educate. The most challenging part was writing the app from scratch and intergrating the different reactive objects and interactive visualisations into one seamless application.

https://szablah.shinyapps.io/opioid/
