FROM python:3.11-slim
WORKDIR /app
# Reference copies "ex3-flash-sale.py" but runs "app:app"; the module must be app.py
COPY app.py .
RUN pip install --no-cache-dir flask gunicorn
EXPOSE 5000
CMD ["gunicorn","-b","0.0.0.0:5000","app:app","--workers","1","--threads","2"]
