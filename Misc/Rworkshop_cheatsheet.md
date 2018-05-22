#R Workshop Cheatsheet


|Rstudio Commands|shortcut| What is does|
|---|---|---|
|**<-**|ctrl/alt + '-'| Assignment operator, "=" sign |
|**%>%**|ctrl/cmd + shift + m|  Pipe function, effectively a "then" statement |
|**comment**|ctrl/cmd + shift + c| Annotating your code|
|**new section**|ctrl/cmd + shift + r| Creating a new section|
|**new code chunk**|alt + ctrl/cmd + i|Create new code chunk|


|tidyverse|shortcut|general formula|
|---|---|---|
|**read_csv**|read .csv file|`read_csv("your_file.csv")`|
|**write_csv**| create .csv file| `write_csv(dataframe, "your_new_file.csv")`|
|**gather**|wide -> long|`gather(category, numerical, x:z)`| 
|**spread**|long -> wide| `spread(category, numerical,)` | 
|**separate**|split column into multiple columns|`separate(date, into = c("month","day","year"), sep = "_")`|
|**unite**|merge multiple columns|`unite(month_day, month, day, sep = "_")`|
|**filter**|pick specific values|`filter(gene == "SOX2")`  `filter(gene %in% c("SOX2", "OCT4")`|
|**select**|pick specific columns|`select(genus,species,genes)`|  
|**arrange**|sort column names|`arrange(column)` `arrange(desc(column)`|
|**rename**|change column values|`rename(new_name = old_name)`| 
|**mutate**|create new column from existing data|`mutate(log2_value= log2(value))` `mutate(new_column = col_A - col_B`|
|**group_by**|'lock-in' by variables|`group_by(dose,date,treatment)`| 
|**summarise/summarize**|aggregate data|`summarise(avg_value = mean(value))`|


# Markdown
 An elegant way to format text using plain text. Use this to format R markdown documents.  
 
#### Markdown editors
**Windows** - markdowndownpad   
**MacOS** - macdown

|What|Input|Output|
|---|---|---|
|Bold|`**Your Text Here**` or `__Your Text Here__` |**Your Text Here**|  
|Italics|`*Your Text Here*` or `_Your Text Here_`|*Your Text Here*|  
|Bold and Italics|`***Your Text Here***`|***Your Text Here***|


 
`# Biggest header`  
# Biggest header  


`## Big header`  
## Big header

`### Smaller header`   
 
### Smaller header


`#### Even smaller`  
#### Even smaller








