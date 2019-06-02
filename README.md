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

post join_event
    event_id
    user_name
{
    status:
        0 - ok
    user_id
    event_name
    presentation_url
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

post get_event_messages
    event_id
{
   status:
       0 - ok
   messages: [
        { user_name, text, is_question }
   ]
}
```

## Схема WebSocket:

```
server connect
    event_id
    user_id
    
server disconnect_listener
    event_id
    user_id
    
===================
  
server disconnect_presenter
    event_id
    user_id
    
client event_end
    
===================
    
server new_message
    event_id
    user_id
    user_name
    text
    is_question
    
client get_message
    user_name
    text
    is_question
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
    event_id int
    
    foreign key(event_id) references event(id)
    
message
    id int primary key
    text string not null
    user_id int
    
    foreign key(user_id) references user(id)
```