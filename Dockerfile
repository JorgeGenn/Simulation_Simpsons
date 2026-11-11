# 1. Usar la imagen base oficial de RStudio sobre Ubuntu (Linux)
FROM rocker/rstudio:latest

# 2. Instalar dependencias del sistema operativo necesarias para R, tidyverse y el paquete 'fs'
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libicu-dev \
    libuv1-dev \
    libwebp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Crear y configurar el directorio de trabajo dentro del contenedor
WORKDIR /home/rstudio/proyecto_transcriptomica

# 4. Copiar primero los archivos del entorno para aprovechar el caché de Docker
COPY renv.lock .
COPY .Rprofile .
COPY renv/activate.R renv/

# 5. Restaurar las librerías usando binarios precompilados para Ubuntu Jammy
RUN Rscript -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); install.packages('renv'); renv::restore(prompt = FALSE)"

# 6. Copiar el resto del código y los datos (.Rmd, HTML, carpeta data/)
COPY . .

# 7. Otorgar permisos al usuario de RStudio
RUN chown -R rstudio:rstudio /home/rstudio/proyecto_transcriptomica

# 8. Exponer el puerto por defecto de RStudio Server
EXPOSE 8787
