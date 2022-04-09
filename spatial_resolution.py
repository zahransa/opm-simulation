import mne
from mne.datasets import sample
from mne.minimum_norm import make_inverse_resolution_matrix
from mne.minimum_norm import resolution_metrics


# read forward solution
forward = mne.read_forward_solution(fname_fwd)
# forward operator with fixed source orientations
mne.convert_forward_solution(forward, surf_ori=True,
                             force_fixed=True, copy=False)

# noise covariance matrix
noise_cov = mne.read_cov(fname_cov)

# evoked data for info
evoked = mne.read_evokeds(fname_evo, 0)

# make inverse operator from forward solution
# free source orientation
inverse_operator = mne.minimum_norm.make_inverse_operator(
    info=evoked.info, forward=forward, noise_cov=noise_cov, loose=0.,
    depth=None)

# regularisation parameter
snr = 3.0
lambda2 = 1.0 / snr ** 2

# %%
# MNE
# ---
# Compute resolution matrices, peak localisation error (PLE) for point spread
# functions (PSFs), spatial deviation (SD) for PSFs:

rm_mne = make_inverse_resolution_matrix(forward, inverse_operator,
                                        method='MNE', lambda2=lambda2)
ple_mne_psf = resolution_metrics(rm_mne, inverse_operator['src'],
                                 function='psf', metric='peak_err')
sd_mne_psf = resolution_metrics(rm_mne, inverse_operator['src'],
                                function='psf', metric='sd_ext')
