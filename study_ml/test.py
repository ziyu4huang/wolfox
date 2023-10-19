import requests

AI21_api_key = 'AI21studio api key'
url = "https://api.ai21.com/studio/v1/answer"
payload = {
    "context": ' '.join(final),
    "question": user_question
}
headers = {
    "accept": "application/json",
    "content-type": "application/json",
    "Authorization": f"Bearer {AI21_api_key}"
}

response = requests.post(url, json=payload, headers=headers)

if response.json()['answerInContext']:
    print(response.json()['answer'])
else:
    print('The answer is not found in the document ⚠️, please reformulate your question.')

