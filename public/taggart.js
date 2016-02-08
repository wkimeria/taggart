$(document).ready(
    function()
    {
        $('#tagCounts li').click(function () {
            $(this).siblings('li').css("fontWeight", "normal");
            $(this).css("fontWeight", "bold");
            highlightItem(this.innerHTML.split(" - ")[0]);
        });

    });

function highlightItem(n){

    regexp_start = new RegExp( "(<" + n + "([^>]+)>)", 'ig');
    regexp_end = new RegExp("</" + n + ">", 'ig');
    regexp_empty = new RegExp("<" + n + "/>", 'ig');

    $('#sourceCode').innerHTML = "#{source}";


    $('#sourceCode').highlightRegex();
    $('#sourceCode').highlightRegex(regexp_start);
    $('#sourceCode').highlightRegex(regexp_end);
    $('#sourceCode').highlightRegex(regexp_empty);


}