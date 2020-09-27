<cfoutput>
    <!--- Markdown editor --->
    <!--- https://github.com/sparksuite/simplemde-markdown-editor --->
    <script src="#request.assetsPath#/vendor/sparksuite-simple-mde/simplemde-1.11.2.min.js"></script>
    <link rel="stylesheet" href="#request.assetsPath#/vendor/sparksuite-simple-mde/simplemde-1.11.2.min.css">
    
    <script>
        var isPreview = false;
        var config = { element: $(".md-editor")[0], promptURLs: true };
        <cfif prc.currentRoute is "preview/">
            isPreview = true;
            // config.toolbar = false;
        </cfif>
        var simplemde = new SimpleMDE( config );
        if( isPreview ) {
            simplemde.togglePreview();
        }
    </script>
</cfoutput>