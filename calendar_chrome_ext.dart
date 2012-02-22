#import('dart:html');
#import('EncodeDecode.dart');

class CalendarChromeExt {
  InputElement _what;
  InputElement _where;
  InputElement _whenStart;
  InputElement _whenEnd;
  List<InputElement> inputs;
  
  InputElement _url;
  AnchorElement _urlTry;
  InputElement _html;

  CalendarChromeExt() {
    // save DOM elements to variables
    _what = document.query("#what");
    _where = document.query("#where");
    _whenStart = document.query("#whenStart");
    _whenEnd = document.query("#whenEnd");
    inputs = [_where, _what, _whenStart, _whenEnd];
    _url = document.query("#url");
    _urlTry = document.query("#urlTry");
    _html = document.query("#html");
    
    // add listener to each of the inputs
    inputs.forEach((InputElement inputEl) {
      inputEl.on.input.add(recompute);
    });
  }
  
  void recompute(Event event) {
    // generate the URL via StringBuffer (much more efficient)
    StringBuffer _strBuffer = new StringBuffer();
    _strBuffer.add("http://www.google.com/calendar/event?action=TEMPLATE");
    _strBuffer.add("&text=");
    _strBuffer.add(encodeURI(_what.value));
    _strBuffer.add("&dates=");
    RegExp findDashesAndColons = const RegExp(@"(\-|\:)");
    _strBuffer.add(encodeURI(_whenStart.value.replaceAll(findDashesAndColons, "")));
    _strBuffer.add("/");
    _strBuffer.add(encodeURI(_whenEnd.value.replaceAll(findDashesAndColons, "")));
    _strBuffer.add("&location=");
    _strBuffer.add(encodeURI(_where.value));
    _strBuffer.add("&trp=false");
    String url = _strBuffer.toString();
    String html = '<a href="$url" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button6.gif" alt="0" border="0"></a>';

    // update DOM elements
    _url.value = url;
    _urlTry.href = url;
    _html.value = html;
  }
}

void main() {
  new CalendarChromeExt();
}
