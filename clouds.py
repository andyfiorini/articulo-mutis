#!/usr/bin/python3.8
#
# Autor: Andres Garcia Fiorini
# Fecha: 15/06/2020
#

from nltk.tokenize import word_tokenize
from nltk.probability import FreqDist
import matplotlib.pyplot as plt
from nltk.corpus import treebank
from nltk.corpus import stopwords

import string 
import numpy as np
import pandas as pd
from os import path
from PIL import Image
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator

#from MyFreqDist import myplot

import io
import sys

from sklearn.feature_extraction.text import CountVectorizer
from nltk.tokenize import RegexpTokenizer

analisis_str = sys.argv[1].replace('txt','an.txt')
png_str = sys.argv[1].replace('txt','png')
wc_str = sys.argv[1].replace('txt','wc.png')

ana = open(analisis_str,'w')
png = open(png_str,'w')
wc = open(wc_str,'w')

stop_words = open('../stop_words_spanish.txt','r').read().split(",")

# Open the input file
myfile = io.open(sys.argv[1], mode="r", encoding="utf-8")
data=myfile.read()

# Tokenize words
tokenized_text=word_tokenize(data)

# Filter words
filtered_sent=[]
for w in tokenized_text:
    if w not in stop_words:
        filtered_sent.append(w)

# Frequency dist
fdist = FreqDist(filtered_sent)
s = ' '
words = s.join(filtered_sent)

# Display the generated image:
wordcloud = WordCloud(max_font_size=50, max_words=100, background_color="white").generate(words)
plt.figure()
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.savefig(wc_str)

