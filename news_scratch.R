library(rvest)

source("scratch_data.R")

#directory of store files
data_dir = "/Users/jeffery/developer/R/CS+X_DS/news/"

#get news "p1" content
p1_url = "http://news.ltn.com.tw/"
p1_query = "search/?keyword=%E4%B8%80%E4%BE%8B%E4%B8%80%E4%BC%91&conditions=and&SYear=2017&SMonth=10&SDay=1&EYear=2017&EMonth=11&EDay=31&page="
p1_pages = seq(1,27)

p1_docs_href_df = do.call(rbind,lapply(paste0(p1_url,p1_query,p1_pages),Get_href_df,data_xpath = "//a[@class = 'tit']"))
status = lapply(paste0(p1_url,p1_docs_href_df[["href"]]),
                Download_content,
                data_xpath = "//div[@data-desc = '內文']/p",
                dir = paste0(data_dir,"p1/")
)
  
#get news "p2" content
p2_url = "https://udn.com/"
p2_query = "search/result/2/%E4%B8%80%E4%BE%8B%E4%B8%80%E4%BC%91/"
p2_pages = seq(18,44)
p2_docs_href_df = do.call(rbind,lapply(paste0(p2_url,p2_query,p2_pages),Get_href_df,data_xpath = "//div[@id = 'search_content']/dt/a[@target = '_blank']"))
status = lapply(p2_docs_href_df[["href"]],
                Download_content,
                data_xpath = "//div[@id='story_body_content']/p",
                dir = paste0(data_dir,"p2/")
)

#以下嘗試抓取網頁內容但失敗的部分
p3_url = "http://www.storm.mg/"
p3_query = "site-search/result?q=%E4%B8%80%E4%BE%8B%E4%B8%80%E4%BC%91"
#parent node
read_html(paste0(p3_url,p3_query)) %>% html_nodes(xpath = "//div[@id = 'search_content']")

#child node
read_html(paste0(p3_url,p3_query)) %>% html_nodes(xpath = "//div[@id = 'search_content']/div")


