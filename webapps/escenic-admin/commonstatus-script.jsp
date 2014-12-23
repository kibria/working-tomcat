  <script>
  function helpText(text) {
    var win = window.open("","help","directories=no,location=no,menubar=no,status=yes,toolbar=no,width=350,height=400,scrollbars=yes,resizable=yes");
    win.focus();
    win.document.open("text/html","replace");
    win.document.write("<html><head><title>Help</title></head>");
    win.document.write("<body><html>");
    win.document.write(text);
    win.document.write("</html></body>");
    win.document.close();
  }
  </script>
