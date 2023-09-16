<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Producto de Ferretería</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Agrega SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
    <style>
        /* Agrega estilos personalizados si es necesario */
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="display-4 text-center">Agregar Producto de Ferretería</h1>
        
        <form  method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="codigo_barra" class="form-label">Código de Barras</label>
                <input type="text" class="form-control" id="codigo_barra" name="codigo_barra">
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Producto</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="5" required></textarea>
            </div>
            <div class="mb-3">
                <label for="precio_unitario" class="form-label">Costo Unitario (en USD)</label>
                <input type="number" class="form-control" id="costo_unitario" name="costo_unitario" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="precio_unitario" class="form-label">Precio Unitario (en USD)</label>
                <input type="number" class="form-control" id="precio_unitario" name="precio_unitario" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="cantidad_stock" class="form-label">Cantidad en Stock</label>
                <input type="number" class="form-control" id="cantidad_stock" name="cantidad_stock" required>
            </div>
            <div class="mb-3">
                <label for="imagen" class="form-label">Imagen del Producto</label>
                <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
            </div>
            <div class="mb-3 text-center">
                <button type="submit" class="btn btn-success btn-lg">Agregar Producto</button>
                <button type="button" class="btn btn-secondary btn-lg" onclick="limpiarFormulario()">Limpiar Formulario</button>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- Agrega SweetAlert2 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
          const form = document.querySelector('form');
  
          form.addEventListener('submit', function(event) {
              event.preventDefault(); // Evita el envío del formulario por defecto
  
              // Realiza aquí la lógica para procesar el formulario (envío al servidor, validaciones, etc.)
              
              // Por ejemplo, puedes usar una petición AJAX para enviar los datos al servidor
              // y manejar la respuesta en la función de éxito o error.
  
              // Ejemplo de petición AJAX usando fetch:
              fetch('procesar_producto', {
                  method: 'POST',
                  body: new FormData(form),
              })
              .then(response => {
                  if (response.ok) {
                      return response.json();
                  } else {
                      throw new Error('Hubo un problema al agregar el producto');
                  }
              })
              .then(data => {
                  Swal.fire({
                      title: 'Éxito',
                      text: 'El producto ha sido agregado con éxito',
                      icon: 'success',
                      confirmButtonText: 'Aceptar'
                  }).then((result) => {
                      if (result.isConfirmed) {
                          // Redirige o realiza cualquier acción adicional
                          window.location.href = 'producto_agregado.jsp';
                      }
                  });
              })
              .catch(error => {
                  Swal.fire({
                      title: 'Error',
                      text: error.message,
                      icon: 'error',
                      confirmButtonText: 'Aceptar'
                  });
              });
          });
      });
  </script>
  
    <script>
        function limpiarFormulario() {
            document.getElementById("codigo_barra").value = "";
            document.getElementById("nombre").value = "";
            document.getElementById("descripcion").value = "";
            document.getElementById("precio_unitario").value = "";
            document.getElementById("cantidad_stock").value = "";
            document.getElementById("imagen").value = "";
        }
    </script>
</body>
</html>
