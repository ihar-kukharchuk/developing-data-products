---
title: "The Geographical Centre Of Europe"
author: "Ihar Kukharchuk"
date: "June 08, 2018"
output:
  html_document:
    keep_md: yes
  pdf_document: default
---



### The Geographical Centre Of Europe


```r
library(leaflet)
geocenter_of_europe <- leaflet() %>%
        addTiles() %>%
        addMarkers(lat = 54.9, lng = 25.316667, popup = "The Geographical Centre Of Europe")
geocenter_of_europe
```

<!--html_preserve--><div id="htmlwidget-9b2de06aa4f3771ffa1e" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-9b2de06aa4f3771ffa1e">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[54.9,25.316667,null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"The Geographical Centre Of Europe",null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[54.9,54.9],"lng":[25.316667,25.316667]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
