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
								<div class="col-md">
									{{ domain.name }}
								</div>
								<div class="col-md text-right">
									<a
										:href="domain.checkout"
										target="_blank"
										class="btn btn-info"
										><span class="fa fa-shopping-cart"></span
									></a>
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
import axios from "axios/dist/axios";
import AppItemList from "./AppItemList";

export default {
	name: "app",
	components: {
		AppItemList,
	},
	data() {
		return {
			items: {
				prefix: [],
				suffix: [],
			}
		};
	},
	methods: {
		addItem(item) {
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						mutation ($item: ItemInput) {
							newItem: saveItem(item: $item) {
								id
								type
								description
							}
						}
					`,
					variables: {
						item
					},
				},
			}).then((response) => {
				const query = response.data;
				const newItem = query.data.newItem;
				this.items[item.type].push(newItem);
			});
		},
		getItems(type) {
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						query ($type: String) {
							items: items (type: $type) {
								id
								type
								description
							}
						}
					`,
					variables: {
						type
					}
				},
			}).then((response) => {
				const query = response.data;
				this.items[type] = query.data.items;
			});
		},
		deleteItem(item) {
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						mutation ($id: Int) {
							deleted: deleteItem(id: $id)
						}
					`,
					variables: {
						id: item.id,
					},
				},
			}).then(() => {
				this.getItems(item.type);
			});
		},
	},
	computed: {
		domains() {
			console.log("gerating domains...");
			const domains = [];
			for (const prefix of this.items.prefix) {
				for (const suffix of this.items.suffix) {
					const name = prefix.description + suffix.description;
					const url = name.toLowerCase();
					const checkout = `https://checkout.hostgator.com.br/?a=add&sld=${url}&tld=.com.br`;
					domains.push({
						name,
						checkout,
					});
				}
			}
			return domains;
		},
	},
	created() {
		this.getItems("suffix");
		this.getItems("prefix");
	},
};
</script>

<style>
</style>
