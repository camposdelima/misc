import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;

public class Main {

    public static void main(final String[] args) {
        for (int i = 0;true; i++) {
            try {
                
                if(i % 5 == 0) {
                    throw new RuntimeException("Test exception");
                }

                System.out.println("Hello World");
                URL url = new URL("http://ifconfig.me");
                HttpURLConnection con = (HttpURLConnection) url.openConnection();

                con.setRequestMethod("GET");
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer content = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                    System.out.println(inputLine);
                }
                in.close();

                Thread.sleep(2000);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}