## Read Me

Intention of this little project is to build a small database of Poverty Thresholds from ASPE Definitions. Raw definitions are coming from [here](https://aspe.hhs.gov/poverty-guidelines). 
So far, it contains poverty thresholds from 2000 to 2017. 

__How the Stata files work:__ 
- `aspeDefinitions.do` holds information pertaining to states and year 
- `thresholdGenerator.do` processes the definitions and  handles some exceptions by year and state to create consistent poverty thresholds across states and specified years.
 
__How this project can be useful:__
- it can be incorporated with any existing database that contains statefips code and year identifier. E.g. `merge m:m year state using povThres_2000_2017` 
- to expand it, just modify `aspeDefinitions.do` file and add new definitions as desired  
 
**PS:** There is another measure of poverty, defined by Census Bureau which are used for reporting national poverty levels while ASPE-HHS definitions are used for most means tested programs such as social-security, food-stamp etc.

For any questions, comments or concerns, [@ougnic](https://twitter.com/ougnic)  

