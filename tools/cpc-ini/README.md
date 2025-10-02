# cpc-config

`cpc-config` es una herramienta de línea de comandos para leer y escribir valores en ficheros de configuración de CPCReady`.

## Uso

El programa utiliza la siguiente sintaxis:

### Leer un valor

Para obtener un valor de una sección y clave específicas:

```bash
./cpc-config get <fichero.ini> <seccion> <clave>
```

**Ejemplo:**

```bash
./cpc-config get config.ini database user
```

### Escribir un valor

Para establecer o actualizar un valor para una sección y clave específicas. Si la sección o la clave no existen, se crearán.

```bash
./cpc-config set <fichero.ini> <seccion> <clave> <valor>
```

**Ejemplo:**

```bash
./cpc-config set config.ini database user admin
```

## Compilación

Para compilar el programa, puedes usar `gcc`:

```bash
gcc -I$(brew --prefix)/include -L$(brew --prefix)/lib -o cpc-ini main.c -linih
```
