#!/usr/bin/python3.8
#
# Autor: Andres Garcia Fiorini
# Fecha: 25/06/2020
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

#print(filtered_sent, file=words)

# Frequency dist
fdist = FreqDist(filtered_sent)
s = ' '
words = s.join(filtered_sent)

#print(fdist)
print(fdist.most_common(40), file=ana)

# Arbol de palabras - No pude hacerlo andar
#t = treebank.parsed_sents(fdist)[0]
#t.draw()

# Clean tokens
token = RegexpTokenizer(r'[a-zA-Z0-9]+')

# Contar los tokens y armar una matriz
#cv = CountVectorizer(lowercase=True,stop_words='spanish',ngram_range = (1,1),tokenizer = token.tokenize)
#text_counts = cv.fit_transform(data['Phrase'])

#fdist.plot(30)
# TEST

# imprimir grafico
#samples = [fdist.most_common(40)]
#args = [len(fdist)]
samples = [item for item, _ in fdist.most_common(40)]
freqs = fdist._cumulative_frequencies(samples)

freqs = [fdist[sample] for sample in samples]
ylabel = "Freqcuencia en número"

ax = plt.gca()
ax.grid(True, color="white")
ax.plot(freqs)
ax.set_xticks(range(len(samples)))
ax.set_xticklabels([str(s) for s in samples], rotation=75)
ax.set_xlabel("Palabras")
ax.set_ylabel(ylabel)
plt.subplots_adjust(bottom=0.2)
plt.savefig(png_str)


# create a word cloud with the letter

# Start with one review:
#text = fdist.description[0]

# Create and generate a word cloud image:
wordcloud = WordCloud().generate(words)

# Display the generated image:
wordcloud = WordCloud(max_font_size=50, max_words=100, background_color="white").generate(words)
plt.figure()
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.savefig(wc_str)

