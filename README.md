# Univershare - мобильное приложение для проведения мероприятий

## Схема Rest Api

```
post exists_event
    event_id
{
    status: 
        0 - ok
        1 - not exists
}

post join
    event_id
    user_name
{
    status:
        0 - ok
    user_id
}

post get_event_info
    event_id
{
    status:
        0 - ok
    eventName
    presentation_url
}

post listener_event_exit
    event_id
    user_id
{
    status:
        0 - ok
}

post get_new_event_id
{
    status:
        0 - ok
    event_id
}

post create_event
    event_id
    event_name
    user_name
    presentation_file
{
    status:
        0 - ok
}

post presenter_event_exit
    event_id
{
    status:
        0 - ok
}
```

## Схема WebSocket:

```
get_questions
    questions: [
        { text }
    ]
    
get_messages
    messages: [
        { user_name, text }
    ]
    
send_message
    user_name
    text
    isQuestion
    
event_end
```

## Схема БД

```
event
    id int primary key
    id_code string not null
    name string not null
    presentation_id int
    presenter_id int
    
    foreign key(presentation_id) references presentation(id)
    foreign key(presenter_id) references user(id)
    
presentation
    id int primary key
    url string not null
    
user 
    id int primary key
    name string not null
    
message
    id int primary key
    text string not null
    user_id int
    
    foreign key(user_id) references user(id)
```