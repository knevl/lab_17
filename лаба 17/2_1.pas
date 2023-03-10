type
  TNode = record
    Word: string;
    Count: Integer;
    Next: ^TNode;
  end;
  PNode = ^TNode;

var
  F: Text;
  Root, Current, NewNode: PNode;
  S: string;
  Found: Boolean;

procedure CreateNode(var NewNode: PNode; S: string);
begin
  New(NewNode);
  NewNode^.Word := S;
  NewNode^.Count := 1;
  NewNode^.Next := nil;
end;

procedure MakePlace(var Current: PNode; S: string);
begin
  while (Current^.Next <> nil) and (Current^.Next^.Word < S) do
    Current := Current^.Next;
end;

procedure AddBefore(var Current: PNode; NewNode: PNode);
begin
  NewNode^.Next := Current^.Next;
  Current^.Next := NewNode;
end;

begin
  Assign(F, 'file.txt');
  Reset(F);
  Read(F, S);
  CreateNode(Root, S);
  Root^.Next := nil;
  while not Eof(F) do
  begin
    Read(F, S);
    Current := Root;
    MakePlace(Current, S);
    if (Current^.Next <> nil) and (Current^.Next^.Word = S) then
      Inc(Current^.Next^.Count)
    else
    begin
      CreateNode(NewNode, S);
      AddBefore(Current, NewNode);
    end;
  end;
  Close(F);
  Current := Root;
  while Current <> nil do
  begin
    Writeln('Текст: ',Current^.Word);
    Writeln('Частота: ',Current^.Count);
    Current := Current^.Next;
  end;
end.