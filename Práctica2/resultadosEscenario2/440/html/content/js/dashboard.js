/*
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
var showControllersOnly = false;
var seriesFilter = "";
var filtersOnlySampleSeries = true;

/*
 * Add header in statistics table to group metrics by category
 * format
 *
 */
function summaryTableHeader(header) {
    var newRow = header.insertRow(-1);
    newRow.className = "tablesorter-no-sort";
    var cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 1;
    cell.innerHTML = "Requests";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 3;
    cell.innerHTML = "Executions";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 7;
    cell.innerHTML = "Response Times (ms)";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 2;
    cell.innerHTML = "Network (KB/sec)";
    newRow.appendChild(cell);
}

/*
 * Populates the table identified by id parameter with the specified data and
 * format
 *
 */
function createTable(table, info, formatter, defaultSorts, seriesIndex, headerCreator) {
    var tableRef = table[0];

    // Create header and populate it with data.titles array
    var header = tableRef.createTHead();

    // Call callback is available
    if(headerCreator) {
        headerCreator(header);
    }

    var newRow = header.insertRow(-1);
    for (var index = 0; index < info.titles.length; index++) {
        var cell = document.createElement('th');
        cell.innerHTML = info.titles[index];
        newRow.appendChild(cell);
    }

    var tBody;

    // Create overall body if defined
    if(info.overall){
        tBody = document.createElement('tbody');
        tBody.className = "tablesorter-no-sort";
        tableRef.appendChild(tBody);
        var newRow = tBody.insertRow(-1);
        var data = info.overall.data;
        for(var index=0;index < data.length; index++){
            var cell = newRow.insertCell(-1);
            cell.innerHTML = formatter ? formatter(index, data[index]): data[index];
        }
    }

    // Create regular body
    tBody = document.createElement('tbody');
    tableRef.appendChild(tBody);

    var regexp;
    if(seriesFilter) {
        regexp = new RegExp(seriesFilter, 'i');
    }
    // Populate body with data.items array
    for(var index=0; index < info.items.length; index++){
        var item = info.items[index];
        if((!regexp || filtersOnlySampleSeries && !info.supportsControllersDiscrimination || regexp.test(item.data[seriesIndex]))
                &&
                (!showControllersOnly || !info.supportsControllersDiscrimination || item.isController)){
            if(item.data.length > 0) {
                var newRow = tBody.insertRow(-1);
                for(var col=0; col < item.data.length; col++){
                    var cell = newRow.insertCell(-1);
                    cell.innerHTML = formatter ? formatter(col, item.data[col]) : item.data[col];
                }
            }
        }
    }

    // Add support of columns sort
    table.tablesorter({sortList : defaultSorts});
}

$(document).ready(function() {

    // Customize table sorter default options
    $.extend( $.tablesorter.defaults, {
        theme: 'blue',
        cssInfoBlock: "tablesorter-no-sort",
        widthFixed: true,
        widgets: ['zebra']
    });

    var data = {"OkPercent": 1.476894596241271, "KoPercent": 98.52310540375873};
    var dataset = [
        {
            "label" : "KO",
            "data" : data.KoPercent,
            "color" : "#FF6347"
        },
        {
            "label" : "OK",
            "data" : data.OkPercent,
            "color" : "#9ACD32"
        }];
    $.plot($("#flot-requests-summary"), dataset, {
        series : {
            pie : {
                show : true,
                radius : 1,
                label : {
                    show : true,
                    radius : 3 / 4,
                    formatter : function(label, series) {
                        return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'
                            + label
                            + '<br/>'
                            + Math.round10(series.percent, -2)
                            + '%</div>';
                    },
                    background : {
                        opacity : 0.5,
                        color : '#000'
                    }
                }
            }
        },
        legend : {
            show : true
        }
    });

    // Creates APDEX table
    createTable($("#apdexTable"), {"supportsControllersDiscrimination": true, "overall": {"data": [0.0020592163846838824, 500, 1500, "Total"], "isController": false}, "titles": ["Apdex", "T (Toleration threshold)  ", "F (Frustration threshold)", "Label"], "items": [{"data": [0.0, 500, 1500, "55 /wcal/week.php"], "isController": false}, {"data": [0.0, 500, 1500, "64 /wcal/edit_entry_handler.php"], "isController": false}, {"data": [6.610156310755113E-4, 500, 1500, "60 /wcal/edit_entry.php"], "isController": false}, {"data": [0.0, 500, 1500, "66 /wcal/week.php"], "isController": false}, {"data": [0.0, 500, 1500, "3 /wcal/month.php"], "isController": false}, {"data": [0.014431239388794566, 500, 1500, "30 /wcal/login.php"], "isController": false}, {"data": [0.0046045117075956595, 500, 1500, "1 /wcal"], "isController": false}, {"data": [0.0, 500, 1500, "36 /wcal/month.php"], "isController": false}, {"data": [4.665992689944786E-4, 500, 1500, "59 /wcal/view_entry.php"], "isController": false}, {"data": [0.00452086266953235, 500, 1500, "35 /wcal/login.php"], "isController": false}, {"data": [0.0, 500, 1500, "65 /wcal/edit_entry_handler.php"], "isController": false}, {"data": [4.293185543673406E-4, 500, 1500, "70 /wcal/login.php"], "isController": false}, {"data": [8.19608149246741E-4, 500, 1500, "71 /wcal/index.php"], "isController": false}]}, function(index, item){
        switch(index){
            case 0:
                item = item.toFixed(3);
                break;
            case 1:
            case 2:
                item = formatDuration(item);
                break;
        }
        return item;
    }, [[0, 0]], 3);

    // Create statistics table
    createTable($("#statisticsTable"), {"supportsControllersDiscrimination": true, "overall": {"data": ["Total", 170696, 168175, 98.52310540375873, 4720.9915873834125, 0, 961908, 131068.0, 289832.15000000066, 722474.76, 0.5124095303189512, 0.8923477500892228, 0.0], "isController": false}, "titles": ["Label", "#Samples", "KO", "Error %", "Average", "Min", "Max", "90th pct", "95th pct", "99th pct", "Throughput", "Received", "Sent"], "items": [{"data": ["55 /wcal/week.php", 12950, 12859, 99.29729729729729, 2029.555444015445, 0, 348880, 0.0, 1.0, 36.0, 0.03892372913310529, 0.06499624055387596, 0.0], "isController": false}, {"data": ["64 /wcal/edit_entry_handler.php", 12833, 12833, 100.0, 0.607418374503237, 0, 155, 1.0, 1.0, 12.659999999999854, 1285.6141053897015, 2079.8999722938793, 0.0], "isController": false}, {"data": ["60 /wcal/edit_entry.php", 12859, 12840, 99.85224356481841, 2.4009643051559215, 0, 4815, 0.0, 1.0, 9.0, 815.047220637637, 1325.7510314658998, 0.0], "isController": false}, {"data": ["66 /wcal/week.php", 12811, 12811, 100.0, 0.444305674810711, 0, 147, 0.0, 1.0, 8.0, 1283.9246341952296, 2077.40006529991, 0.0], "isController": false}, {"data": ["3 /wcal/month.php", 13603, 13168, 96.80217599059031, 17840.899654487952, 0, 961908, 1.0, 131069.0, 421445.48, 0.04083945933479513, 0.09924039058318655, 0.0], "isController": false}, {"data": ["30 /wcal/login.php", 13547, 13197, 97.41640215545877, 5121.660589060307, 0, 299029, 1.0, 76.39999999999418, 229390.52, 0.04072330579188938, 0.06684753804263038, 0.0], "isController": false}, {"data": ["1 /wcal", 14008, 13265, 94.69588806396345, 19770.390205596806, 0, 748795, 4.0, 129431.15, 735919.82, 0.04208347573458618, 0.06672621884619595, 0.0], "isController": false}, {"data": ["36 /wcal/month.php", 13278, 12896, 97.12306070191293, 10351.237083898184, 0, 461869, 1.0, 1.0, 387710.3099999998, 0.03989311109876014, 0.09304503232956893, 0.0], "isController": false}, {"data": ["59 /wcal/view_entry.php", 12859, 12848, 99.91445680068435, 1.63418617310833, 0, 5216, 0.0, 1.0, 8.0, 846.5437788018432, 1370.0148380924952, 0.0], "isController": false}, {"data": ["35 /wcal/login.php", 13493, 13045, 96.679759875491, 3924.245905284221, 0, 307207, 1.0, 59.69999999999345, 190460.06, 0.040558818456840874, 0.06544585296154853, 0.0], "isController": false}, {"data": ["65 /wcal/edit_entry_handler.php", 12833, 12822, 99.9142834878828, 3.7531364451024682, 0, 6020, 1.0, 1.0, 14.0, 802.1627703462932, 1296.9384844980623, 0.0], "isController": false}, {"data": ["70 /wcal/login.php", 12811, 12799, 99.90633049722895, 1.7005698228085244, 0, 4690, 0.0, 1.0, 6.0, 874.0533533465239, 1413.4549884440883, 0.0], "isController": false}, {"data": ["71 /wcal/index.php", 12811, 12792, 99.85168995394582, 2.0463664038716716, 0, 4764, 0.0, 1.0, 9.0, 852.3619427811044, 1377.9812120550566, 0.0], "isController": false}]}, function(index, item){
        switch(index){
            // Errors pct
            case 3:
                item = item.toFixed(2) + '%';
                break;
            // Mean
            case 4:
            // Mean
            case 7:
            // Percentile 1
            case 8:
            // Percentile 2
            case 9:
            // Percentile 3
            case 10:
            // Throughput
            case 11:
            // Kbytes/s
            case 12:
            // Sent Kbytes/s
                item = item.toFixed(2);
                break;
        }
        return item;
    }, [[0, 0]], 0, summaryTableHeader);

    // Create error table
    createTable($("#errorsTable"), {"supportsControllersDiscrimination": false, "titles": ["Type of error", "Number of errors", "% in errors", "% in all samples"], "items": [{"data": ["Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 660, 0.39244834250037164, 0.3866522941369452], "isController": false}, {"data": ["Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 771, 0.45845101828452506, 0.45168017996906784], "isController": false}, {"data": ["Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 166744, 99.1491006392151, 97.68477292965271], "isController": false}]}, function(index, item){
        switch(index){
            case 2:
            case 3:
                item = item.toFixed(2) + '%';
                break;
        }
        return item;
    }, [[1, 1]]);

        // Create top5 errors by sampler
    createTable($("#top5ErrorsBySamplerTable"), {"supportsControllersDiscrimination": false, "overall": {"data": ["Total", 170696, 168175, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 166744, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 771, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 660, null, null, null, null], "isController": false}, "titles": ["Sample", "#Samples", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors"], "items": [{"data": ["55 /wcal/week.php", 12950, 12859, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12859, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["64 /wcal/edit_entry_handler.php", 12833, 12833, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12833, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["60 /wcal/edit_entry.php", 12859, 12840, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12840, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["66 /wcal/week.php", 12811, 12811, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12811, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["3 /wcal/month.php", 13603, 13168, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12779, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 201, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 188, null, null, null, null], "isController": false}, {"data": ["30 /wcal/login.php", 13547, 13197, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12843, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 239, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 115, null, null, null, null], "isController": false}, {"data": ["1 /wcal", 14008, 13265, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12784, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 306, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 175, null, null, null, null], "isController": false}, {"data": ["36 /wcal/month.php", 13278, 12896, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12863, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 24, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 9, null, null, null, null], "isController": false}, {"data": ["59 /wcal/view_entry.php", 12859, 12848, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12848, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["35 /wcal/login.php", 13493, 13045, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12871, "Non HTTP response code: java.net.SocketException/Non HTTP response message: Connection reset", 145, "Non HTTP response code: java.net.ConnectException/Non HTTP response message: Expir&oacute; el tiempo de conexi&oacute;n (Connection timed out)", 29, null, null, null, null], "isController": false}, {"data": ["65 /wcal/edit_entry_handler.php", 12833, 12822, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12822, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["70 /wcal/login.php", 12811, 12799, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12799, null, null, null, null, null, null, null, null], "isController": false}, {"data": ["71 /wcal/index.php", 12811, 12792, "Non HTTP response code: java.net.UnknownHostException/Non HTTP response message: virtual.lab.inf.uva.es", 12792, null, null, null, null, null, null, null, null], "isController": false}]}, function(index, item){
        return item;
    }, [[0, 0]], 0);

});
