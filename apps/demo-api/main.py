from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(title="Demo API")
Instrumentator().instrument(app).expose(app)

@app.get("/health")
def health():
    return {"status": "ok", "version": "1.0.0"}

@app.get("/hello")
def hello(name: str = "world"):
    return {"message": f"Hello {name}!"}
