# -*- coding: utf-8 -*-
"""
Created on Tue Aug 15 18:04:09 2017

@author: AutuanLiu
"""
# pyts的使用

import numpy as np
from scipy.stats import norm
	
n_samples = 10
n_features = 48
n_classes = 2
	
delta = 0.5
dt = 1
x = 0.
	
X = np.zeros((n_samples, n_features))
X[:, 0] = x
	
for i in range(n_samples):
    start = x
    for k in range(1, n_features):
        start += norm.rvs(scale=delta**2 * dt)
        X[i][k] = start
	
y = np.random.randint(n_classes, size=n_samples)

from pyts.visualization import plot_ts

plot_ts(X[0])

from pyts.transformation import StandardScaler

standardscaler = StandardScaler(epsilon=1e-2)
X_standardized = standardscaler.transform(X)

from pyts.visualization import plot_standardscaler

plot_standardscaler(X[0])

from pyts.transformation import PAA

paa = PAA(window_size=None, output_size=8, overlapping=True)
X_paa = paa.transform(X_standardized)

from pyts.visualization import plot_paa

plot_paa(X_standardized[0], window_size=None, output_size=8, overlapping=True, marker='o')

from pyts.transformation import SAX

sax = SAX(n_bins=5, quantiles='gaussian')
X_sax = sax.transform(X_paa)

from pyts.visualization import plot_sax

plot_sax(X_paa[0], n_bins=5, quantiles='gaussian')

from pyts.visualization import plot_paa_sax

plot_paa_sax(X_standardized[0], window_size=None, output_size=8, overlapping=True, n_bins=5, quantiles='gaussian')