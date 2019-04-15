# 
# 
# 
#server.R
library(shiny)
library(plotly)
library(leaflet)
library(dplyr)

load("all.RData", envir = .GlobalEnv)
load("PS.RData", envir = .GlobalEnv)

function(input, output, session){
  
  observeEvent(input$button1, {
    updateTabsetPanel(session, "inTabset", selected = "tab3")
  })
  
  observeEvent(input$button2, {
    updateTabsetPanel(session, "inTabset", selected = "tab4")
  })
  
  observeEvent(input$button3, {
    updateTabsetPanel(session, "inTabset", selected = "tab1")
  })
  
  output$plot1 <- renderPlotly({
    if(input$select=="Age"){
      ageGroupsData %>%
        group_by(ageGroups, Year) %>%
        filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
                 drugAlcoholInducedCause == "All other drug-induced causes"|
                 drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
                 drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
        summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
        plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~ageGroups, mode = "lines+markers")}
    else if(input$select=="Race"){
      raceData %>%
        group_by(race, Year) %>%
        filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
                 drugAlcoholInducedCause == "All other drug-induced causes"|
                 drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
                 drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
        summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
        plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~race, mode = "lines+markers")}
    
    else{
      ggplotly(genderData %>%
                 group_by(gender, Year) %>%
                 filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
                          drugAlcoholInducedCause == "All other drug-induced causes"|
                          drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
                          drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
                 summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
                 plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~gender, mode = "lines+markers"))}
  })
  
  observeEvent(input$toTab2, {
    updateTabsetPanel(session, "titleHead",
                      selected = "tab2")
  })
  
  output$plot2_1 <- renderPlotly({
    ageGroupsData %>%
      filter(ageGroups != "NS", Year == input$yearChoice_1, drugAlcoholInducedCause == input$input1_1) %>%
      group_by(Year, ageGroups) %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~ageGroups, y = ~TotalDeaths, type = "bar", color = ~ageGroups)
  })
  
  output$plot2_2 <- renderPlotly({
    raceData %>%
      filter(Year == input$yearChoice_2, drugAlcoholInducedCause == input$input1_2) %>%
      group_by(Year, race) %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~race, y = ~TotalDeaths, type = "bar", color = ~race) 
  })
  
  
  output$plot2_3 <- renderPlotly({
    genderData %>%
      filter(Year == input$yearChoice_3, drugAlcoholInducedCause == input$input1_3) %>%
      group_by(Year, gender) %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~gender, y = ~TotalDeaths, type = "bar", color = ~gender) 
  })
  
  output$plot3 <- renderLeaflet({
    myTemp <- ageGroupsData %>%
      group_by(County) %>%
      filter(Year == input$yearChoice, drugAlcoholInducedCause == input$deathChoice) %>%
      summarize(`Total Death Number` = sum(Deaths), Longitude = mean(longitude), Latitude = mean(latitude)) %>%
      arrange(desc(`Total Death Number`)) %>%
      head(input$numObs1)
    
    leaflet(myTemp) %>%
      addTiles() %>%
      addCircles(lng = ~`Longitude`, lat = ~`Latitude`, radius = ~`Total Death Number`*20) %>%
      setView(lng = -99.48, lat = 39.7, zoom = 5)
  })
  
  output$table1 <- renderDataTable({
    ageGroupsData %>%
      group_by(County) %>%
      filter(Year == input$yearChoice, drugAlcoholInducedCause == input$deathChoice) %>%
      summarize(`Total Death Number` = sum(Deaths), `Longitude` = mean(longitude), `Latitude` = mean(latitude)) %>%
      arrange(desc(`Total Death Number`)) 
  })
  
  output$deathrates <- renderPlotly({
    ggplotly(PState_wrangled %>% 
               filter(State==input$`Select State`) %>% 
               ggplot(.,aes(x=Year,y=Crude_Death_Rate,color=Sex))+geom_line()+facet_wrap(~Race) + 
               ylab("Crude death rate in %"))
  })
  
  
  output$brkdn <- renderPlotly({
    ggplotly(br_down %>%
               filter(Sex==input$Sex,Age_Group==input$Age) %>% 
               ggplot(.,aes(x=Year,y=Crude_Death_Rate))+geom_line()+facet_wrap(~Race) +
               ylab("Crude death rate in %")) 
  })
  
}   