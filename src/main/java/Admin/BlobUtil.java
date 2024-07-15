package Admin;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

public class BlobUtil {
    public static String blobToBase64(Blob blob) {
        try {
            byte[] blobBytes = blob.getBytes(1, (int) blob.length());
            return Base64.getEncoder().encodeToString(blobBytes);
        } catch (SQLException e) {
            e.printStackTrace();
            return "";
        }
    }
}
