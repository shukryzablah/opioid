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
  
  observeEvent(input$toTab2, {
    updateTabsetPanel(session, "titleHead",
                      selected = "tab2")
  })
  
  
  output$plot1 <- renderPlotly({
    ageGroupsData %>%
      group_by(ageGroups, Year) %>%
      filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
               drugAlcoholInducedCause == "All other drug-induced causes"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~ageGroups, mode = "lines+markers") 
  })
  
  output$plot1_2 <- renderPlotly({
    raceData %>%
      group_by(race, Year) %>%
      filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
               drugAlcoholInducedCause == "All other drug-induced causes"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~race, mode = "lines+markers") 
  })
  
  output$plot1_3 <- renderPlotly({
    genderData %>%
      group_by(gender, Year) %>%
      filter(drugAlcoholInducedCause == "Drug poisonings (overdose) Unintentional (X40-X44)"|
               drugAlcoholInducedCause == "All other drug-induced causes"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Suicide (X60-X64)"|
               drugAlcoholInducedCause == "Drug poisonings (overdose) Undetermined (Y10-Y14)") %>%
      summarize(numObs = n(), TotalDeaths = sum(Deaths)) %>%
      plot_ly(x = ~Year, y = ~TotalDeaths, type = 'scatter', color = ~gender, mode = "lines+markers") 
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
  
  output$map <- renderPlotly({
    plot_geo(PS, locationmode = 'USA-states') %>%
      add_trace(
        z = ~Age_Adjusted_Rate, text = ~hover, locations = ~code,
        color = ~Age_Adjusted_Rate, colors = 'Purples'
      ) %>%
      colorbar(title = "Rate") %>%
      layout(
        title = '<br>Age-adjusted and crude death rates <br> <br>',
        geo = g
      )
  })
  
  output$brkdn <- renderPlotly({
    ggplotly(br_down %>%
               filter(Sex==input$Sex,Age_Group==input$Age) %>% 
               ggplot(.,aes(x=Year,y=Crude_Death_Rate))+geom_line()+facet_wrap(~Race) +
               ylab("Crude death rate in %")) 
  })
  
  output$Aftermath <- renderImage({
    outfile <- tempfile(fileext = '.png')
    png(outfile, width = 1000, height = 700)
  })
  
  observeEvent({input$beginning1+input$beginning2+input$beginning3+input$beginning4+input$beginning5+input$beginning6+input$beginning7+input$beginning3.5}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab0")
  })
  
  observeEvent({input$toTab1_0+input$toTab1_1}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab1")
  })
  
  observeEvent({input$toTab2_1+input$toTab2_2}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab2")
  })
  
  observeEvent({input$toTab3_1+input$toTab3_2}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab3")
  })
  
  observeEvent({input$toTab3.5_1+input$toTab3.5_2}, {
    updateTabsetPanel(session, "inTabset", 
                      selected = "tab3.5")
  })
  
  
  observeEvent({input$toTab4_1+input$toTab4_2}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab4")
  })
  
  observeEvent({input$toTab5_1+input$toTab5_2}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab5")
  })
  
  observeEvent({input$toTab6_1+input$toTab6_2}, {
    updateTabsetPanel(session, "inTabset",
                      selected = "tab6")
  })
  
  observeEvent({input$toTab7_0+input$toTab7_1+input$toTab7_2+input$toTab7_3+input$toTab7_4+input$toTab7_5+input$toTab7_6+input$toTab7_7},{
    updateTabsetPanel(session, "inTabset", 
                      selected = "tab7")
  })
  
  output$Consequences <- renderImage({
    outfile <- tempfile(fileext = '.png')
    png(outfile, width = 1000, height = 700)
  })
  
  output$Addiction <- renderImage({
    outfile <- tempfile(fileext = '.png')
    png(outfile, width = 1000, height = 700)
  })
  
}   