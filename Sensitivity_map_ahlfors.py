import numpy as np
import mne
import matplotlib.pyplot as plt


# Read the forward solutions with surface orientation
fwd = mne.read_forward_solution(fwd_fname)
mne.convert_forward_solution(fwd, surf_ori=True, copy=False)
leadfield = fwd['sol']['data']
print("Leadfield size : %d x %d" % leadfield.shape)

# %%
# Compute sensitivity maps


mag_map = mne.sensitivity_map(fwd, ch_type='mag', mode='fixed')


# %%
# Show gain matrix a.k.a. leadfield matrix with sensitivity map

plt.hist([mag_map.ravel()], bins=20, color=['g'],label='λ')

plt.legend()

plt.axis([ -0.00001,0.00025, 0, 8000])

plt.title("OPMt2")
plt.xlabel('sensitivity')
plt.ylabel('count')
plt.show()
#plt.xlim(0,0.00025)
