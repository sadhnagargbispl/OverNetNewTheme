 



/*   This function for view Chart in Diffrent  look
_______________________________________________________
Created by : Fida Husain [ALPS Softech]
Updated By : -----
Date : 10 Oct 2014 
_______________________________________________________
*/


/*
all search text box on Admin panel
Search from to this logic
 
==> This funcatyion Used for Searching Member Change only textbox id and Button id it Work proper
*/


$(function () {
    $("#Quick_member_Serch").keyup(function (event) {
        if (event.keyCode == 13) {
            $("#btn_QuickMemberSearch").click();
        }
    })
});

$(function () {
    $("#btn_QuickMemberSearch").click(function () {
        var searchtext = $('#Quick_member_Serch').val();
        //        var url = 'http://www.awesome.alpssoftech.us/BOA/MemberSearch.aspx?search_text=' + searchtext
        var url = 'MemberSearch.aspx?search_text=' + searchtext
        $(location).attr('href', url);
    })
});

/*   This function for view Chart in Diffrent  look
Created by : Fida Husain [ALPS Softech]
Reference : http:www.highchart.com
Date : 10 Oct 2014 */

/*
this funcation used for Display the Graph in diffrent Way
*/
function view1(view_val) {
 
    var options = {
        chart: {
            renderTo: 'customeranalysis',
            type: view_val
        },
        title: {
            text: 'Order Analysis Chart'
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: 'No of Orders'
            }
        },
        series: []
    };

    // Load the data from the XML file 
    $.get('../Data/Memberdatabybranch.xml', function (xml) {
        // Split the lines
        var $xml = $(xml);
        // push categories
        $xml.find('categories item').each(function (i, category) {
            options.xAxis.categories.push($(category).text());
        });
        // push series
        $xml.find('series').each(function (i, series) {
            var seriesOptions = {
                name: $(series).find('name').text(),
                data: []
            };
            // push data points
            $(series).find('data point').each(function (i, point) {
                seriesOptions.data.push(
							parseInt($(point).text())
						);
            });

            // add it to the options
            options.series.push(seriesOptions);
        });
        var chart = new Highcharts.Chart(options);
    });
}

function view(view_val) {
    var options = {
        chart: {
            renderTo: 'Memberanalysis',
            type: view_val
        },
        title: {
            text: 'Member Analysis Chart'
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: 'No of Member'
            }
        },
        series: []
    };

    // Load the data from the XML file 
    $.get('../Data/Memberdata.xml', function (xml) {
        // Split the lines
        var $xml = $(xml);
        // push categories
        $xml.find('categories item').each(function (i, category) {
            options.xAxis.categories.push($(category).text());
        });
        // push series
        $xml.find('series').each(function (i, series) {
            var seriesOptions = {
                name: $(series).find('name').text(),
                data: []
            };
            // push data points
            $(series).find('data point').each(function (i, point) {
                seriesOptions.data.push(
							parseInt($(point).text())
						);
            });

            // add it to the options
            options.series.push(seriesOptions);
        });
        var chart = new Highcharts.Chart(options);
    });
}



//***************************************************************************************  Excel Export *******************************************************************


/*   This function use for Generater Excel Report from Html Table or Repeater .
_______________________________________________________
Created by : Fida Husain [ALPS Softech]
Updated By : -----
Date : 14 Jan 2017
_______________________________________________________
*/


/*
Generate Excel Report 
When you want to genearte Excel Report then call tableToExcel() funcation from .aspx page or .cs page using  Button or Anchor link 

when you call tableToExcel() funcation pass three Paramenter 
1. TableID  =>  Firts parameter is Table id means which table contain all Data  pass this ID
2. Sheet Name  => Excel Sheet Name if you want to Customize Excel Sheet Name then Pass Second Parameter
3. HeaderText => Header Text  in Top level in Our Table

 
==> This funcatyion Used for Searching Member Change only textbox id and Button id it Work proper

Example : - 
(Anchor Tag) =   <a href="#"  onclick="tableToExcel('TableID', 'Sheet1' , 'TABLE HEADER ALL LIST')"  ></a>
(Button ) =     <input type="button" onclick="tableToExcel('TableID', 'Sheet1' , 'TABLE HEADER ALL LIST')" value="Export to Excel">  
(Sever Button ) =     <asp:Button ID="Button1" OnClientClick="tableToExcel('TableID', 'Sheet1' , 'TABLE HEADER ALL LIST')" Text="Export to Excel"> 
            
*/



var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,'
                , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
                , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
    return function (table, name, tableheader) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: '<caption>' + tableheader + '</caption>' + table.innerHTML }
        window.location.href = uri + base64(format(template, ctx))
    }
})()
 