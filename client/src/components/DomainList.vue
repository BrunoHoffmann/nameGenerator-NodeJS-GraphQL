<template>
	<div id="main">
		<div class="container">
			<div class="row">
				<div class="col-md">
					<app-item-list
						:items="items.prefix"
						type="prefix"
						v-on:addItem="addItem"
						v-on:deleteItem="deleteItem"
						title="Prefixos"
					></app-item-list>
				</div>

				<div class="col-md">
					<app-item-list
						:items="items.suffix"
						type="suffix"
						v-on:addItem="addItem"
						v-on:deleteItem="deleteItem"
						title="Suffixos"
					></app-item-list>
				</div>
			</div>
			<br />
			<h5>
				Domínios <span class="badge badge-info">{{ domains.length }}</span>
			</h5>
			<div class="card">
				<div class="card-body">
					<div class="list-group">
						<li
							class="list-group-item"
							v-for="domain in domains"
							:key="domain.name"
						>
							<div class="row">
								<div class="col-md-6">
									{{ domain.name }}
								</div>
								<div class="col-md-3">
									<span class="badge badge-info">{{ (domain.available) ? 'Disponível' : 'Não Disponível' }}</span>
								</div>
								<div class="col-md text-right">
									<a
										:href="domain.checkout"
										target="_blank"
										class="btn btn-info"
										><span class="fa fa-shopping-cart"></span
									></a>
									&nbsp;
									<button class="btn btn-info" @click="openDomain(domain)">
										<span class="fa fa-search"></span>
									</button>
								</div>
							</div>
						</li>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import AppItemList from "./AppItemList";

export default {
	name: "app",
	components: {
		AppItemList,
	},
	data() {
		return {};
	},
	methods: {
		...mapActions(["addItem", "deleteItem", "getItems", "generateDomains"]),
		openDomain(domain) {
			this.$router.push({
				path: `/domains/${domain.name}`,
			});
		},
	},
	computed: {
		...mapState(["items", "domains"])
	}
};
</script>

<style>
</style>
