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

    regex_str = "(<" + n + "([^>]+)>)" + "|"  + "</" + n + ">" + "|" + "<" + n + "/>" + "|" + "<" + n + ">";
    regexp = new RegExp(regex_str, 'ig');
    console.log(regex_str);


    //This is a hack. The highlightRegex() method does not work correctly, and in some cases
    //ends up deleting elements from the HTML. So rather than using it, ust reload the whole
    //document from hidden div upon click
    $('#sourceCode').html($('#sourceCodeShadow').html());

    //$('#sourceCode').highlightRegex();
    $('#sourceCode').highlightRegex(regexp);



}