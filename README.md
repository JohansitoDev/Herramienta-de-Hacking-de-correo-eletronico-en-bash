# Herramienta-de-Hacking-de-correo-eletronico-en-bash

# Email-Bruteforce

¡Hola\! Soy el creador de **Email-Bruteforce**, una herramienta básica que escribí en Bash para aprender sobre la seguridad de los servidores de correo electrónico. Mi objetivo con este script es que sirva como una base educativa para entender cómo funciona un ataque de fuerza bruta contra un servidor SMTP.

**Advertencia:** Por favor, utiliza esta herramienta solo en sistemas que te pertenezcan o con el permiso explícito de los administradores. El uso no autorizado es ilegal y poco ético.

-----

### ¿Qué hace?

`email-bruteforce.sh` intenta adivinar la contraseña de un correo electrónico específico. Lo hace probando una lista de contraseñas que tú le proporcionas, una por una. El script se conecta al servidor SMTP del dominio y simula un intento de inicio de sesión para cada contraseña. Si alguna de ellas funciona, ¡la he encontrado\!

-----

### Requisitos

Antes de usar el script, asegúrate de tener instalada la herramienta **`telnet`**. La mayoría de los sistemas operativos la traen por defecto, pero si no la tienes, puedes instalarla.

Por ejemplo, en Debian/Ubuntu:

```bash
sudo apt-get install telnet
```

-----

### Cómo usar mi herramienta

Sigue estos pasos para que mi script funcione correctamente:

1.  **Guarda el script:**
    Copia el código de `email-bruteforce.sh` en un archivo con el mismo nombre y la extensión `.sh`.

2.  **Crea una `wordlist`:**
    Necesitas un archivo de texto que contenga las contraseñas que quieres probar, una por línea. Te recomiendo crear un archivo llamado `passwords.txt` con algunas contraseñas comunes.

    Ejemplo de `passwords.txt`:

    ```
    123456
    password
    qwerty
    test1234
    ```

3.  **Dale permisos de ejecución:**
    Para que el sistema operativo sepa que mi script es un programa ejecutable, debes darle los permisos adecuados con el comando `chmod`.

    ```bash
    chmod +x email-bruteforce.sh
    ```

4.  **Ejecútalo:**
    Ahora, ya puedes ejecutar mi script desde tu terminal. Solo necesitas pasarle tres argumentos:

      * **`-e`**: La dirección de correo electrónico a la que quieres atacar.
      * **`-s`**: El servidor SMTP del dominio (ej: `smtp.gmail.com`).
      * **`-w`**: La ruta a tu archivo de `wordlist` de contraseñas.

    Aquí tienes un ejemplo de cómo lo usaría:

    ```bash
    ./email-bruteforce.sh -e tu_objetivo@ejemplo.com -s smtp.ejemplo.com -w ./passwords.txt
    ```

Si el script encuentra una contraseña que funciona, te lo dirá y se detendrá. Si no, ¡seguirá intentándolo hasta que se acaben las contraseñas de tu lista\!

-----

### Mejoras que tengo en mente

Mi script es solo el principio. Si quieres mejorarlo, te sugiero que intentes añadirle lo siguiente:

  * **Soporte para SSL/TLS:** Actualmente, solo funciona en conexiones no cifradas (puerto 25). Sería ideal añadir soporte para puertos seguros como 465 o 587 usando `openssl`.
  * **Gestión de `timeouts` y errores:** Si el servidor se desconecta o la conexión falla, el script podría manejar esos errores de forma más elegante.

¡Espero que te sea útil para tus estudios de ciberseguridad\!
