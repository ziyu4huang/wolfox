# uvicorn.exe --host 0.0.0.0 main:app 

from typing import Optional

from fastapi import FastAPI
from fastapi import Request
import logging

app = FastAPI()


#logging.basicConfig(level=logging.INFO, filename='log.txt', filemode='w',
logging.basicConfig(level=logging.INFO, 
	format='[%(asctime)s %(levelname)-8s] %(message)s',
	datefmt='%Y%m%d %H:%M:%S',
	)

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}


@app.post("/dummypath")
async def get_body(request: Request):
    v = await request.json()
    logging.info(v)


    return v