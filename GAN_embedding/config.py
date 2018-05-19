import numpy as np
from datetime import date

batch_size_dis = 64  # batch size for discriminator
batch_size_gen = 64  # batch size for generator

lambda_dis = 1e-5  # l2 loss regulation factor for discriminator
lambda_gen = 1e-5  # l2 loss regulation factor for generator

n_sample_dis = 20  # sample num for generator
n_sample_gen = 20  # sample num for discriminator

update_ratio = 1    # updating ratio when choose the trees
save_steps = 10

lr_dis = 1e-4  # learning rate for discriminator
lr_gen = 1e-3  # learning rate for discriminator

max_epochs = 20  # outer loop number
max_epochs_gen = 30  # loop number for generator
max_epochs_dis = 30  # loop number for discriminator

gen_for_d_iters = 10  # iteration numbers for generate new data for discriminator
max_degree = 0  # the max node degree of the network

model_log = "../../log/iteration/"

use_mul = True # control if use the multiprocessing when constructing trees
load_model = False  # if load the model for continual training
gen_update_iter = 200
window_size = 3

n_embed = 128
n_node = 19373
pretrain_emd_filename = "../../pre_train/encode.emb"
gene_network_filename = "../../data/encode.txt"

models = ["dis", "gen"]
emb_filenames = ["../../pre_train/" + models[0] + "_" + date.isoformat() + ".emb",
                 "../../pre_train/" + models[1] + "_" + date.isoformat() + ".emb"]
result_filename = "../../results/"+ date.isoformat() +".txt"

