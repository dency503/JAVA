import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/procesar_producto")
@MultipartConfig
public class ProcesarProductoServlet extends HttpServlet {

   String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=FerreteriaA";
    String DB_USER = "DESKTOP-ETLARI4\\SQLEXPRESS";


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Registrar el controlador JDBC (debes haber agregado el controlador a tu proyecto)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Establecer la conexión a la base de datos
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=FerreteriaA;integratedSecurity=true");

            // Obtener los parámetros del formulario
            String nombre = request.getParameter("nombre");

            // Validar que se proporcionó un nombre
            if (nombre == null || nombre.trim().isEmpty()) {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "El nombre del producto es obligatorio");
            } else {
                // Crear la consulta SQL para insertar el producto en la base de datos
                String sql = "INSERT INTO Productos (nombre) VALUES (?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, nombre);

                // Ejecutar la consulta
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Éxito: El producto se ha agregado correctamente
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "El producto ha sido agregado con éxito");
                } else {
                    // Error: No se pudo agregar el producto
                   jsonResponse.put("status", "error");
                    jsonResponse.put("message", "No se pudo agregar el producto");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Error en la base de datos: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Error en la base de datos: " + se.getMessage());
            }

            // Configurar la respuesta JSON
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println(jsonResponse.toString());
        }
    }
}