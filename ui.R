#ui.R
library(shiny)
library(plotly)
library(leaflet)
library(dplyr)
library(shinythemes)

navbarPage(title = "The Opioid Crisis in America", id = "inTabset", collapsible = TRUE,  fluid = TRUE,theme = shinytheme("yeti"),
           
           
           tabPanel(
             title = "Stratification across age, race & gender", 
             value = "tab1",
             sidebarLayout(position = "right",sidebarPanel(h3("Show trends across:"),
                          width = 3, 
                          selectInput(inputId = "select",
                                      label = "Select",
                                      choices = c("Age","Race","Gender"
                                      ),selected = "Age")
             ),mainPanel(tags$h1("Deaths"),
                         plotlyOutput(outputId = "plot1"),br(),br(),br(),
                         div(style="display:inline-block;width:100%;margin-left: 500px;",actionButton(inputId = "button1", label = "Next"))))
           ),
           
           tabPanel(
             title = "Worst hit areas",
             value = "tab3",
             sidebarLayout(position = "right", sidebarPanel(h3("Tweak parameters:"),
                                                            width=3,
                                                            sliderInput(inputId = "numObs1", label = "Number of Counties to Plot:", min = 5, max = 3000, value = 1000, width = "850px"),
                                                            selectInput(inputId = "deathChoice",
                                                                        label = "Choose type of death:",
                                                                        choices = c("Unintentional" = "Drug poisonings (overdose) Unintentional (X40-X44)",
                                                                                    "Other" = "All other drug-induced causes",
                                                                                    "Suicide" = "Drug poisonings (overdose) Suicide (X60-X64)",
                                                                                    "Undetermined" = "Drug poisonings (overdose) Undetermined (Y10-Y14)")),
                                                            sliderInput(inputId = "yearChoice", label = "Choose Year to Plot:", min = 1999, max = 2016, value = 1999, width = "500px", animate = TRUE, sep = "")
             ),mainPanel(tags$h1("Map of Top Counties Affected By Crisis"),
                         leafletOutput(outputId = "plot3", width = "100%", height = "450px"),
                         div(style="display:inline-block;width:100%;margin-left: 1100px;",actionButton(inputId = "button2", label = "Next")),
                         tags$h1("Table of Top Counties Arranged By Total Deaths"),
                         dataTableOutput(outputId = "table1")))
           ),
           
           tabPanel(
             title = "Trends by state", 
             value = "tab4",
             sidebarLayout(position = "right",
                           sidebarPanel(h3("Breakdown by state:"),
                                        width = 3, 
                                        selectInput(inputId = "Select State",
                                                    label = "Select State",
                                                    choices = c("Alabama",
                                                                "Alaska",
                                                                "Arizona",
                                                                "Arkansas",
                                                                "California",
                                                                "Colorado",
                                                                "Connecticut",
                                                                "Delaware",
                                                                "Florida",
                                                                "Georgia",
                                                                "Hawaii",
                                                                "Idaho",
                                                                "Illinois",
                                                                "Indiana",
                                                                "Iowa",
                                                                "Kansas",
                                                                "Kentucky",
                                                                "Louisiana",
                                                                "Maine",
                                                                "Maryland",
                                                                "Massachusetts",
                                                                "Michigan",
                                                                "Minnesota",
                                                                "Mississippi",
                                                                "Missouri",
                                                                "Montana",
                                                                "Nebraska",
                                                                "Nevada",
                                                                "New Hampshire",
                                                                "New Jersey",
                                                                "New Mexico",
                                                                "New York",
                                                                "North Carolina",
                                                                "North Dakota",
                                                                "Ohio",
                                                                "Oklahoma",
                                                                "Oregon",
                                                                "Pennsylvania",
                                                                "Rhode Island",
                                                                "South Carolina",
                                                                "South Dakota",
                                                                "Tennessee",
                                                                "Texas",
                                                                "Utah",
                                                                "Vermont",
                                                                "Virginia",
                                                                "Washington",
                                                                "West Virginia",
                                                                "Wisconsin",
                                                                "Wyoming")),p("Click the link below to see the documentation for this app:"),a(href="https://raymondnzaba.com/OpioidCrisis.html","Making sense of the opioid crisis.")
                           ),
                           
                           mainPanel(
                             tags$h1("Crude death rates over time"),
                             plotlyOutput(outputId = "deathrates"
                             ),br(),br(),br()
                           )))
)