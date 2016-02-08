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

    $('#sourceCode').removeHighlight();
    $('#sourceCode').highlight('<' + n);
    $('#sourceCode').highlight(n + '>');
    $('#sourceCode').highlight(n + '/>');
}