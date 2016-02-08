$(document).ready(
    function()
    {
        $('#tagCounts li').click(function () {
            $(this).siblings('li').css("fontWeight", "normal");
            $(this).css("fontWeight", "bold");
            //data.split(" - ")[0]
            highlightItem(this.innerHTML.split(" - ")[0]);
            //alert(this.innerHTML);
        });

    });

function highlightItem(n){

    regexp_start = new RegExp( "(<" + n + "([^>]+)>)", 'ig');
    regexp_end = new RegExp("</" + n + ">", 'ig');
    regexp_empty = new RegExp("<" + n + "/>", 'ig');


    $('#sourceCode').highlightRegex();
    $('#sourceCode').highlightRegex(regexp_start);
    $('#sourceCode').highlightRegex(regexp_end);
    $('#sourceCode').highlightRegex(regexp_empty);


}