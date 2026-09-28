CREATE TABLE bank_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance NUMERIC(10,2)
);

CREATE TABLE customer_audit (
    audit_id SERIAL PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(50),
    action VARCHAR(20),
    action_time TIMESTAMP
);

INSERT INTO bank_customer VALUES
(1, 'Rahul', 50000),
(2, 'Neha', 75000);


create or replace function customer_audit_function()
returns trigger
language plpgsql
as $$
begin
if tg_op = 'insert' then
insert into customer_audit
(customer_id, customer_name, action, action_time)
values
(new.customer_id, new.customer_name, 'added', current_timestamp);
return new;
elsif tg_op = 'delete' then
insert into customer_audit
(customer_id, customer_name, action, action_time)
values
(old.customer_id, old.customer_name, 'removed', current_timestamp);
return old;
end if;
end;
$$;