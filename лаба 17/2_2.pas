type
  PNode = ^Node;
  Node = record
    word: string;
    count: integer;
    next: PNode;
  end;

function CreateNode(NewWord: string): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.word := NewWord;
  NewNode^.count := 1;
  NewNode^.next := nil;
  Result := NewNode;
end;

procedure AddFirst(var Head: PNode; NewNode: PNode);
begin
  NewNode^.next := Head;
  Head := NewNode;
end;

procedure AddAfter(p, NewNode: PNode);
begin
  NewNode^.next := p^.next;
  p^.next := NewNode;
end;

procedure AddLast(var Head: PNode; NewNode: PNode);
var
  q: PNode;
begin
  if Head = nil then
    AddFirst(Head, NewNode)
  else begin
    q := Head;
    while q^.next <> nil do
      q := q^.next;
    AddAfter(q, NewNode);
  end;
end;

procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var
  q: PNode;
begin
  q := Head;
  if p = Head then 
    AddFirst(Head, NewNode)
  else begin
    while (q <> nil) and (q^.next <> p)
      do
      q := q^.next;
    if q <> nil then AddAfter(q, NewNode);
  end;
end;

procedure AddBefore2(p, NewNode: PNode);
var
  temp: Node;
begin
  temp := p^; p^ := NewNode^;
  NewNode^ := temp;
  p^.next := NewNode;
end;

function Find(Head: PNode; NewWord: string): PNode;
var
  q: PNode;
begin
  q := Head;
  while (q <> nil) and (NewWord <> q^.word) do
    q := q^.next;
  Result := q;
end;

function FindPlace(Head: PNode; NewWord: string): PNode;
var
  q: PNode;
begin
  q := Head;
  while (q <> nil) and (NewWord > q^.word) do
    q := q^.next;
  Result := q;
end;

procedure DeleteNode(var Head: PNode; p: PNode);
var
  q: PNode;
begin
  if Head = p then
    Head := p^.next
  else begin
    q := Head;
    while (q <> nil) and (q^.next <> p) do
      q := q^.next;
    if q <> nil then q^.next := p^.next;
  end;
  Dispose(p);
end;

function GetWord(F: Text): string;
var
  c: char;
begin
  Result := '';
  c := ' ';
  
  while not eof(f) and (c <= ' ') do
    read(F,c);
  begin
      while not eof(f) and (c > ' ') do begin
    Result := Result + c;
    read(F, c);
  end;
end;
end;

var
  F: Text;
  Head: PNode;
  q: PNode;
  s: string;
  a: integer;

begin
  Head := nil;
  Assign(F, 'file 2.2.txt');
  Reset(F);
  while not eof(F) do
  begin
    s := GetWord(F);
    if Find(Head, s) = nil then
      AddBefore(Head, FindPlace(Head, s), CreateNode(s))
    else Find(Head, s)^.count += 1;
  end;
  close(F);
  q := Head;
  a:=1;
  while q <> nil do
  begin
    if (a mod 2)=0 then
    writeln('Число: ',q^.word, '  Строка: ', q^.count);
    a+=1;
    q := q^.next;
  end;
end.