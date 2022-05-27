# Open Toolkit Page Sequence Splitting Plug-In

This plug-in enables generating arbitrary page sequences from nested topics.

The base PDF2 transform generates new page sequences for each top-level topic (part, chapter, etc.), which means that it is not directly possible to start new page sequences within the scope of the base page sequence boundaries without doing something special.

This plug-in provides a post-process to the initially-generated XSL-FO document that uses marker elements (dita-ot:page-sequence-start and dita-ot:page-sequence-end) to split the original page sequences into multiple pages sequences.

This allows you to do things like render specific tables or images on landscape pages or use different page layouts for content within specific topics or trees within the maps.

*NOTE:* This plug-in does not provide a way to set the top-level page sequence names. That is done using normal PDF2 override techniques set the page sequence master for a given chapter or part (or equivalent top-level topic). This plugin is specifically for triggering new page masters *within* the PDF2-generated top-level page sequences. This means that specifying the `page-sequence_*` @outputclass values on topicrefs that already generate new page sequences will have no effect.

## Generating page sequence start/end markers

The plug-in provides a general extension point that you can extend in your own extension XSLT to generate page sequence markers for whatever reason.

However, the plug-in supports the use of @outputclass on specific elements to trigger generation of page sequence markers.

The outputclass value is of the form:

```
page-sequence_{page-sequence-master-name}
page-sequence-start_{page-sequence-master-name}
page-sequence-end_{page-sequence-master-name}
```

Where _page-master-name_ is the name of a page sequence master defined in the XSL-FO, i.e. "body-sequence".

The form `page-sequence_{page-sequence-master-name}` generates start and end markers at the start and end of the containing element.

The form `page-sequence-start_{page-sequence-master-name}` generates a page sequence start marker before the start of the specifying element.

The form `page-sequence-end_{page-sequence-master-name}` generates a page sequence end markup after the end of the specifying element.

Use the first form if at all possible to ensure that your start/end markers are properly paired. For example, if you have a sequence of topics within a chapter that should all be within the same page sequence, wrap them in a `<topicgroup>` element and put the `page-sequence_{page-sequence-master-name}` outputclass on the topic group.

Within the body of a topic you should be able to use `<div>` or `<section>` as appropriate.

