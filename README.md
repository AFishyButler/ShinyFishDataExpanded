# ShinyFishData 🐟

This B4 assignment is option C- an expansion of assignemtn B3, option B.


## Repository contents

Welcome to the Shiny Fish Data Expanded repository! Here you will find the contents for the STAT545B B4 assignment. I decided to do a re-vamp of my Shiny Fish Data dashboard with a demonstration of some interactive data exploration of a new dataset, *Fry_thermal_maximum*. This dataset includes the thermal tolerance performance of both the swim trials of the previous dataset as well as the results for the stationary bath test. On the dashboard you will be able to interact with fork length measurements and dropout temperatures as sorted by mass and acclimation treatment and test type through histograms and tables; interact with the dataset as a whole and download the dataset; look at some fish and watch them swim.

**Full list of additions and changes**
1. Use of page tabs for high-level nagivation and drop-down tabs to prevent cluttering
2. Tabset panels nested within the relevant page; limiting the visual real-estate the sidebar panels take up to only where necessary
3. Allowing the user to select multiple acclimation temperatures
4. Introduction of a second filter for data; test type choice



Enjoy!

|Click here for the deployed app |
| ------------- | 
| https://natalie-afishybutler.shinyapps.io/ShinyFishDataExpanded/ |

| Click here for the previous version| 
| ------------- | 
|  https://natalie-afishybutler.shinyapps.io/ShinyFishData/ | 


### Files

*.gitignore:* This specifies untracked files to be deliberately ignored by Git.

*README.md:* This file! This file delineates all the general information regarding the contents of this repository, with descriptions of all folders and their contents.

*ShinyFishDataExpanded.Rproj:* Contains the project options and can be used as a shortcut for opening the project directly from the file system. You'll also find a second folder of the same name

*app.R:* Code written to power the app.

*Fry_thermal_maximum.csv:* Dataset required to run the app.

### Folders

**ShinyFishDataExpanded:** Contains all the material components to the shiny app. In this folder you will find *Fry_thermal_maximum.csv*, which is the dataset required to run the app. Contains the file *app.R*, which contains the code written to power the app.

**rsconnect/shinyapps.io/natalie-afishybutler:** This folder contains the file *ShinyFishDataExpanded.dcf*, which is a display mode.

**www:** Contains all media embedded in the app in *.png* format.
