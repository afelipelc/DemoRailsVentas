Aplicación Rails como demo
Se trata de un ejemplo básico de punto de venta.

<b>24 junio 2014</b>
Se ha agregado autentificación a la aplicación con <b>Devise<b> y la guía http://guides.railsgirls.com/devise/, por lo que deberas realizar la migración de la BD si cuentas ya con una copia anterior de este ejemeplo.

En application controller, deberás deshabilitar la instrucción

>before_action :authenticate_user!

de lo contrario no podrás ingresar porque es obligatorio el inicio de sesión.

ejecuta el servidor, e ingresa en http://0.0.0.0:3000/users/sign_up

podrás volver a activar la instrucción anterior y verificar que ya funciona la autentificación.
--------------