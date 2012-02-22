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
    _what = document.query("#what");
    _where = document.query("#where");
    _whenStart = document.query("#whenStart");
    _whenEnd = document.query("#whenEnd");
    
    inputs = [_where, _what, _whenStart, _whenEnd];
    
    _url = document.query("#url");
    _urlTry = document.query("#urlTry");
    _html = document.query("#html");
    
    inputs.forEach((InputElement input) {
      input.on.input.add(recompute);
    });
  }
  
  void recompute(Event event) {
    print("Changed.");
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
    
    _url.value = url;
    _urlTry.href = url;
    _html.value = html;
  }
  
  // output <a href="http://www.google.com/calendar/event?action=TEMPLATE&text=Abc%20%C5%98eho%C5%99&dates=20101231T230000Z/20101231T230000Z&details=ABC%20Desc&location=ABC%20%C5%98e%C5%99i%C5%A1%C3%ADn%2C%20150%2000&trp=false&sprop=www.google.cz&sprop=name:ABC%20%C5%98emdich" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button6.gif" alt="0" border="0"></a>
}

void main() {
  new CalendarChromeExt();
}
