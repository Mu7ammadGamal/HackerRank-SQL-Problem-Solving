--MSSQL

declare @i int = 1, @j int, @c int = 0, @res varchar(2000) = ''
while(@i<=1000) 
begin
    set @j = @i
    while(@j>0)
    begin        
        if(@i%@j = 0)
        begin            
            set @c +=1            
        end        
        set @j -= 1
    end    
    if(@c = 2)
    begin
        set @res += (cast(@i as varchar(3)) + '&')        
    end
    set @c = 0    
    set @i += 1
end
print trim('&' from @res)

