import asyncio
from fastapi import FastAPI, WebSocket

from pydantic_model.chat_body import ChatBody
from services.llm_service import LLMService
from services.sort_service import SortService
from services.search_service import SearchService
app = FastAPI()
search_service = SearchService()
sort_service = SortService()
llm_service = LLMService()

@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        await asyncio.sleep(0.1)
        print("Waiting to receive data...")
        data = await websocket.receive_json()
        print(f"Received data: {data}")
       
        query = data.get("query")
        print(f"Processing query: {query}")
        search_results =  search_service.web_search(query)
    
        sorted_results =  sort_service.sort_sources(query,search_results)
       
        await asyncio.sleep(0.1)

        await websocket.send_json({
            'type': 'search_result',
            'data': sorted_results
        })
       

    
        for chunk in llm_service.generate_response(query, sorted_results):
            await asyncio.sleep(0.1)
            await websocket.send_json({"type":"content", "data":chunk})
            
       
    
    except:
        print("Unexpected error occuered")

    finally:
        await websocket.close()    


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_results =  search_service.web_search(body.query)
    
    sorted_results =  sort_service.sort_sources(body.query,search_results)
    
    response = llm_service.generate_response(body.query, sorted_results)
    return response 


 